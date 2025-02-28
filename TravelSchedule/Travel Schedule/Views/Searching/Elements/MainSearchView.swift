//
//  MainSearchView.swift
//  Travel Schedule
//
//  Created by Niykee Moore on 13.01.2025.
//

import SwiftUI

struct MainSearchView: View {
    private let searchButtonTitle = "Найти"
    private let dummyDirection = ["Откуда", "Куда"]

    @Binding var navPath: [ViewsRouter]
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: SearchScreenViewModel

    var body: some View {
        searchWidget
        if viewModel.isSearchButtonReady {
            searchButton
        }
        Spacer()
    }
}

// MARK: - Private views
private extension MainSearchView {
    var searchWidget: some View {
        HStack(alignment: .center, spacing: AppSizes.Spacing.large) {
            destinationsList
            swapButton
        }
        .padding(AppSizes.Spacing.large)
        .background(AppColors.Universal.blue)
        .clipShape(RoundedRectangle(cornerRadius: AppSizes.CornerRadius.xLarge))
        .frame(height: AppSizes.Height.searchingForm)
        .padding(.top, AppSizes.Spacing.xLarge)
        .padding(.horizontal, AppSizes.Spacing.large)
    }

    var swapButton: some View {
        ZStack {
            Circle()
                .foregroundStyle(AppColors.Universal.white)
                .frame(width: AppSizes.Size.swappingButton)
            Button {
                viewModel.swapDestinations()
            } label: {
                AppImages.Icons.swap
                    .foregroundStyle(AppColors.Universal.blue)
            }
        }
    }

    var searchButton: some View {
        NavigationLink(value: ViewsRouter.routeView) {
            Text(searchButtonTitle)
                .setCustomButton(width: AppSizes.Width.searchButton, padding: .all)
        }
    }

    var destinationsList: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(viewModel.destinations.enumerated()), id: \.offset) { index, destination in
                    let city: String = destination.city.title
                    let station: String = destination.station.title.isEmpty ? "" : " (\(destination.station.title))"
                    let destinationLabel: String = city.isEmpty ? dummyDirection[index] : city + station
                    NavigationLink(value: ViewsRouter.cityView) {
                        HStack {
                            Text(destinationLabel)
                                .foregroundStyle(
                                    rootViewModel.state == .loading
                                    ? Color.clear
                                    : (city.isEmpty ? AppColors.Universal.gray : AppColors.Universal.black)
                                )
                            Spacer()
                        }
                        .padding(AppSizes.Spacing.large)
                        .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.searchingRow)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            viewModel.setDirection(to: JourneyType(rawValue: index) ?? .departure)
                        }
                    )
                }
            }
            .background(AppColors.Universal.white)
            .clipShape(RoundedRectangle(cornerRadius: AppSizes.CornerRadius.xLarge))
            if rootViewModel.state == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .ccBlack))
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainSearchView(
            navPath: .constant([]),
            rootViewModel: RootViewModel(yandexAPIService: YandexAPIService(apikey: YandexAPIConfig.APIKEY)),
            viewModel: SearchScreenViewModel(destinations: Mocks.Destinations.sample)
        )
    }
}
