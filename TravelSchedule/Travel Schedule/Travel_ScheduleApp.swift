
import SwiftUI

@main
struct Travel_ScheduleApp: App {
    @StateObject var settings = SettingsViewModel(yandexAPIService: YandexAPIService(apikey: YandexAPIConfig.APIKEY))

    var body: some Scene {
        WindowGroup {
            RootTabView(
                destinationsViewModel: SearchScreenViewModel(),
                rootViewModel: RootViewModel(yandexAPIService: YandexAPIService(apikey: YandexAPIConfig.APIKEY))
            )
                .environmentObject(settings)
                .environment(\.colorScheme, settings.darkMode ? .dark : .light)
        }
    }
}
