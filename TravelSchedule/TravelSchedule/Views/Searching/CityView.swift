//
//  CityView.swift
//  Travel Schedule
//
//  Created by Niykee Moore on 13.01.2025.
//

import SwiftUI

struct CityView: View {
    private let title = "Выбор города"
    private let notification = "Город не найден"
    
    @Binding var schedule: Schedule
    @Binding var navPath: [ViewsRouter]
    @Binding var direction: JourneyType
    
    @State private var searchString = String()
    
    private var searchingResults: [City] {
        searchString.isEmpty
        ? schedule.cities
        : schedule.cities.filter { $0.title.lowercased().contains(searchString.lowercased()) }
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            SearchBarView(searchText: $searchString)
            if searchingResults.isEmpty {
                SearchResultEmptyView(notification: notification)
            } else {
                ScrollView(.vertical) {
                    ForEach(searchingResults) { city in
                        NavigationLink(value: ViewsRouter.stationView) {
                            RowSearchView(rowString: city.title)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            if var destination = schedule.destinations[direction] {
                                destination.cityTitle = city.title
                                schedule.destinations[direction] = destination
                            }
                        })
                        .setRowElement()
                        .padding(.vertical, AppSizes.Spacing.large)
                    }
                }
                .padding(.vertical, AppSizes.Spacing.large)
            }
            Spacer()
        }
        .setCustomNavigationBar(title: title)
        .foregroundStyle(AppColors.LightDark.black)
        .onAppear {
            searchString = String()
        }
    }
}

#Preview {
    NavigationStack {
        CityView(schedule: .constant(Schedule.sampleData), navPath: .constant([]), direction: .constant(.departure))
    }
}
