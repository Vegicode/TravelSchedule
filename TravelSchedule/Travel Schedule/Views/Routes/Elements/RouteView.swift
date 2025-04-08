 
import SwiftUI

struct RouteView: View {
    
   
    @ObservedObject var viewModel: RouteViewModel

    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero) {
            RouteCarrierView(viewModel:RouteCarrierViewModel( route: viewModel.route, carrier: viewModel.carrier), carrierIcon: .constant(Image(systemName: "cablecar"))
            )
            timelineView
        }
        .background(AppColors.Universal.lightGray)
        .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.route)
        .clipShape(RoundedRectangle(cornerRadius: AppSizes.CornerRadius.xxLarge))
        .task {
            let placeholderLogo = Image(systemName: viewModel.carrier.placeholder)
            viewModel.carrierIcon = viewModel.carrier.logoSVGUrl.isEmpty
            ? await viewModel.imageDownloader.fetchImage(from: viewModel.carrier.logoUrl) ?? placeholderLogo
            : await viewModel.imageDownloader.fetchSvgImage(from: viewModel.carrier.logoSVGUrl) ?? placeholderLogo
        }
    }
}

// MARK: - Private views
private extension RouteView {
    var timelineView: some View {
        HStack(spacing: .zero) {
            timeDetailsView(field: .left, title: viewModel.route.departureTime)
            Spacer()
            timeDetailsView(field: .center, title:  viewModel.route.durationTime)
            Spacer()
            timeDetailsView(field: .right, title: viewModel.route.arrivalTime)
        }
        .background(
            lineView
        )
        .foregroundStyle(AppColors.Universal.black)
        .padding(.vertical, AppSizes.Spacing.medium)
        .padding(.horizontal, AppSizes.Spacing.small)
        .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.timeLine)
    }

    var lineView: some View {
        Rectangle()
            .frame(height: AppSizes.Line.small)
            .foregroundStyle(AppColors.Universal.gray)
    }
}

// MARK: - Private methods
private extension RouteView {
    func timeDetailsView(field: FieldPosition, title: String) -> some View {
        Text(title)
            .font(field == .center ? AppFonts.Regular.small : AppFonts.Regular.medium)
            .padding(.horizontal, AppSizes.Spacing.xSmall)
            .background(AppColors.Universal.lightGray)
    }

    enum FieldPosition {
        case left, center, right
    }
}

#Preview {
    RouteCarrierView(viewModel:RouteCarrierViewModel( route: Mocks.Routes.all[0], carrier: Mocks.Carriers.rzhd), carrierIcon: .constant(Image(systemName: "cablecar"))
    )
}
