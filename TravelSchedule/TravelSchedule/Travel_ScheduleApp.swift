//
//  Untitled.swift
//  TravelSchedule
//
//  Created by Mac on 13.02.2025.
//

import SwiftUI

@main
struct Travel_ScheduleApp: App {
    
    @State private var schedule = Schedule.sampleData
    @State private var darkMode = false
    var body: some Scene {
        WindowGroup{
            RootTabView(schedule: $schedule, darkMode: $darkMode)
                .environment(\.colorScheme, darkMode ? .dark : .light)
        }
    }
}
