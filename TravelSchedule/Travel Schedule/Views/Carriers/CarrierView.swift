
import SwiftUI



struct CarrierView: View {
    // MARK: - Properties
    @ObservedObject var view: CarrierViewModel
    @Environment(\.openURL) private var openURL
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            imageView
            titleView
            show(info: view.carrier.email, for: .email)
            show(info: view.carrier.phone, for: .phone)
            show(info: view.carrier.contacts, for: .contacts)
            Spacer()
        }
        .padding(.horizontal, AppSizes.Spacing.large)
        .setCustomNavigationBar(title: view.title)
    }
}

// MARK: - Private views
private extension CarrierView {
    enum ContactType {
        case email, phone, contacts

        var title: String {
            switch self {
                case .email: "E-mail"
                case .phone: "Телефон"
                case .contacts: "Контакты"
            }
        }
    }
    var carrierTitle: String { "ОАО «\(view.carrier.title)»" }
    var emailUrl: String { "mailto:" + view.carrier.email }
    var phoneUrl: String { "tel:" + view.carrier.phone }

    var imageView: some View {
        AsyncImage(url: URL(string: view.carrier.logoUrl)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            placeholderImageView
        }
        .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.carrierFullLogo)
        .background(AppColors.Universal.white)
        .clipShape(RoundedRectangle(cornerRadius: AppSizes.CornerRadius.xxLarge))
    }

    var placeholderImageView: some View {
        Image(systemName: view.carrier.placeholder)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.carrierFullLogo / 2)
            .padding(.vertical, AppSizes.Height.carrierFullLogo / 4)
    }

    var titleView: some View {
        Text(carrierTitle)
            .font(AppFonts.Bold.medium)
            .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.carrierTitle, alignment: .leading)
            .padding(.vertical, AppSizes.Spacing.large)
    }
}

// MARK: - Private methods
private extension CarrierView {
    func show(info: String, for type: ContactType) -> some View {
        return VStack(alignment: .leading, spacing: .zero) {
            show(header: type.title)
            switch type {
                case .email: showButton(for: .email)
                case .phone: showButton(for: .phone)
            case .contacts: show(info: view.carrier.contacts)
            }
        }.frame(height: type == .contacts ? AppSizes.Height.row * 2 : AppSizes.Height.row)
    }

    func show(header: String) -> some View {
        Text(header)
            .font(AppFonts.Regular.medium)
            .foregroundStyle(AppColors.LightDark.black)
    }

    func show(info: String) -> some View {
        VStack(spacing: .zero) {
            Text(info)
                .font(AppFonts.Regular.small)
                .foregroundStyle(AppColors.LightDark.black)
            Spacer()
        }
    }

    func showButton(for type: ContactType) -> some View {
        Button {
            guard let url = URL(string: type == .email ? emailUrl : phoneUrl) else { return }
            openURL(url)
        } label: {
            show(info: type == .email ? view.carrier.email : view.carrier.phone)
        }
    }
}

#Preview {
    NavigationStack {
        CarrierView(view: CarrierViewModel(carrier: Mocks.Carriers.rzhd, imageDownloader: ImageDownloader()))
    }
}

