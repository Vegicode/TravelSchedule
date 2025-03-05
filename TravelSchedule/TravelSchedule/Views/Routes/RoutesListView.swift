//
//  RoutesListView.swift
//  Travel Schedule
//
//  Created by Niykee Moore on 13.01.2025.
//

import SwiftUI

struct RoutesListView: View {
    @Binding var schedule: Schedule
    @State private var currentFilter = Filter()
    
    private let notification = "Вариантов нет"
    private let buttonTitle = "Уточнить время"
    
    private var departure: String {
        let destination = schedule.destinations[.departure] ?? Destination()
        return destination.cityTitle + " (" + destination.stationTitle + ")"
    }
    
    private var arrival: String {
        let destination = schedule.destinations[.arrival] ?? Destination()
        return destination.cityTitle + " (" + destination.stationTitle + ") "
    }
    
    private var filteredRoutes: [Route] {
        let complexRoutes = currentFilter.isWithTransfers
        ? schedule.routes
        : schedule.routes.filter { $0.isDirect == true }
        var allRoutes = currentFilter.isAtNight
        ? complexRoutes.filter { $0.departureTime.starts(with: /0[0-5]/) }
        : []
        allRoutes += currentFilter.isMorning
        ? complexRoutes.filter { $0.departureTime.starts(with: /0[6-9]/) || $0.departureTime.starts(with: /1[0-1]/) }
        : []
        allRoutes += currentFilter.isAfternoon
        ? complexRoutes.filter { $0.departureTime.starts(with: /1[2-8]/) }
        : []
        allRoutes += currentFilter.isEvening
        ? complexRoutes.filter { $0.departureTime.starts(with: /19/) || $0.departureTime.starts(with: /2[0-4]/) }
        : []
        return allRoutes.sorted { $0.date < $1.date }
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            (Text(departure) + Text(AppImages.Icons.arrow).baselineOffset(-1) + Text(arrival))
                .font(AppFonts.Bold.medium)
            
            if filteredRoutes.isEmpty {
                SearchResultEmptyView(notification: notification)
            } else {
                ScrollView(.vertical) {
                    ForEach(filteredRoutes) { route in
                        if let carrier = schedule.carriers.first(where: { $0.id == route.carrierID }) {
                            NavigationLink {
                                CarrierView(carrier: carrier)
                            } label: {
                                RouteView(route: route, carrier: carrier)
                            }
                        }
                    }
                }
                .padding(.top, AppSizes.Spacing.large)
            }
            Spacer()
            NavigationLink {
                FilterView(filter: $currentFilter)
            } label: {
                HStack(spacing: AppSizes.Spacing.xSmall) {
                    ButtonTitleView(title: buttonTitle)
                    MarkerView(currentFilter: currentFilter)
                }
                .setCustomButton(padding: .top)
            }
        }
        .padding(.horizontal, AppSizes.Spacing.large)
        .setCustomNavigationBar()
    }
}
#Preview {
    NavigationStack {
        RoutesListView(
            schedule: .constant(Schedule.sampleData)
        )
    }
}
