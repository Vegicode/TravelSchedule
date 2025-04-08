 
import SwiftUI

struct RoutesScreen: View {
    // MARK: - Properties
    @State private var isError: Bool = false
    @ObservedObject var viewModel: RoutesScreenViewModel
    @ObservedObject var viewModel2: RouteViewModel
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero) {
            titleView
            switch viewModel.state {
            case .loading:
                loaderView
            case .none:
                emptyView
            default:
                routesList
            }
        }
        .padding(.horizontal, AppSizes.Spacing.large)
        .setCustomNavigationBar()
        .task {
            await fetchData()
        }
        .sheet(isPresented: $isError, onDismiss: {
            isError = false
        }, content: {
            ErrorView(errorType: viewModel.currentError)
        })
    }
}

// MARK: - Private views
private extension RoutesScreen {
    var titleView: some View {
        HStack(spacing: 4) {
            Text(viewModel.departure)
            Image(systemName: "arrow.right")
                .baselineOffset(-1)
            Text(viewModel.arrival)
        }
        .font(AppFonts.Bold.medium)
    }
    
    var loaderView: some View {
        Spacer()
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .ccBlack))
            }
    }
    
    var emptyView: some View {
        SearchResultEmptyView(notification: viewModel.notification)
    }
    
    var routesList: some View {
        VStack(spacing: .zero) {
            routesView
            Spacer()
            buttonView
        }
    }
    
    var routesView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.filteredRoutes) {route in
                if let carrier = viewModel.carriers.first(where: { $0.code == viewModel2.route.carrierCode }) {
                    NavigationLink {
                        CarrierView(view: CarrierViewModel(carrier: carrier, imageDownloader: viewModel.imageDownloader))
                    } label: {
                        RouteView(viewModel: RouteViewModel(route: route, carrier: carrier, imageDownloader: viewModel.imageDownloader))
                    }
                }
            }
        }
        .padding(.top, AppSizes.Spacing.large)
    }
    
    var buttonView: some View {
        NavigationLink {
            FilterView(viewModel: FilterViewModel(viewModelFilter: viewModel.filter))
        } label: {
            buttonTitleView
        }
    }
    
    var buttonTitleView: some View {
        HStack(alignment: .center, spacing: AppSizes.Spacing.xSmall) {
            Text(viewModel.buttonTitle)
            markerView
        }
        .setCustomButton(padding: .top)
    }
    
    var markerView: some View {
        AppImages.Icons.marker
            .resizable()
            .scaledToFit()
            .frame(width: AppSizes.Size.marker, height: AppSizes.Size.marker)
            .foregroundStyle(
                viewModel.filter == Filter.fullSearch ? AppColors.Universal.blue : AppColors.Universal.red
            )
    }
}

// MARK: - Private methods
private extension RoutesScreen {
    func fetchData() async {
        do {
            if viewModel.routes.isEmpty {
                try await viewModel.searchRoutes()
            }
        } catch {
            isError = true
        }
    }
}

#Preview {
    NavigationStack {
        RoutesScreen(
            viewModel: RoutesScreenViewModel(
                destinations: Mocks.Destinations.sample,
                routes: Mocks.Routes.all,
                routesDownloader: RoutesDownloader(yandexAPIService: YandexAPIService(apikey: YandexAPIConfig.APIKEY)),
                imageDownloader: ImageDownloader()),
            viewModel2: RouteViewModel(route: Mocks.Routes.all[0], carrier: Mocks.Carriers.rzhd, imageDownloader: ImageDownloader())
        )
    }
}
