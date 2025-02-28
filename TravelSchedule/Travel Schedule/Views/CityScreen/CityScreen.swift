//
//  CityView.swift
//  Travel Schedule
//
//  Created by Niykee Moore on 13.01.2025.
//

import SwiftUI

struct CityScreen: View {
    @Binding var navPath: [ViewsRouter]
    @ObservedObject var destinationsViewModel: SearchScreenViewModel
    @ObservedObject var viewModel: CityScreenViewModel

    var body: some View {
        VStack(spacing: .zero) {
            SearchBarView(searchText: $viewModel.searchString)
            if viewModel.filteredCities.isEmpty {
                emptyView
            } else {
                listView
            }
            Spacer()
        }
        .setCustomNavigationBar(title: viewModel.title)
        .foregroundStyle(AppColors.LightDark.black)
        .task {
            viewModel.searchString = String()
            viewModel.fetchCities()
        }
        .overlay {
            if viewModel.state == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .ccBlack))
            }
        }
    }
}

private extension CityScreen {
    var emptyView: some View {
        SearchResultEmptyView(notification: viewModel.notification)
    }

    var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: .zero) {
                ForEach(viewModel.filteredCities) { city in
                    NavigationLink(value: ViewsRouter.stationView) {
                        RowView(title: city.title)
                    }
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { destinationsViewModel.saveSelected(city: city) }
                    )
                    .setRowElement()
                    .padding(.vertical, AppSizes.Spacing.large)
                }
            }
        }
        .padding(.vertical, AppSizes.Spacing.large)
    }
}

#Preview {
    NavigationStack {
        CityScreen(
            navPath: .constant([]),
            destinationsViewModel: SearchScreenViewModel(destinations: Mocks.Destinations.sample),
            viewModel: CityScreenViewModel(store: [])
        )
    }
}
