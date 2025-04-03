
import Foundation

@MainActor
final class TravelViewModel: ObservableObject {
    @Published var copyrightInfo = ""
   
    @Published private(set) var stations: [Station] = []
    @Published private(set) var countries: [Components.Schemas.Countries] = []
    @Published private(set) var state: State = .loading
    
    private let yandexAPIService: YandexAPIServiceProtocol
    private var store: Components.Schemas.StationsResponse?
    
    init(yandexAPIService: YandexAPIServiceProtocol) {
        self.yandexAPIService = yandexAPIService
        Task {
            await loadData()
        }
    }
    
    func getCopyright() async {
        do {
            let copyrightService = try await yandexAPIService.copyright()
            let response = try await copyrightService.getCopyright()
            copyrightInfo = response.copyright?.text ?? "Ошибка получения копирайта"
        } catch {
            print("Ошибка в getCopyright: \(error.localizedDescription)")
            state = .error(.connectionError)
        }
    }
    
    func fetchData() async {
        do {
            state = .loading
            let service = try await yandexAPIService.stationsList()
            let stationsResponse = try await service.getStationsGuide()
            store = stationsResponse
            print(stationsResponse)
            state = .loaded
        } catch {
            print("Ошибка в fetchData: \(error.localizedDescription)")
            state = .error(.connectionError)
        }
    }
    

    
    private func loadData() async {
        async let copyrightCall: Void = getCopyright()
        async let fetchCall: Void = fetchData()
        _ = await (copyrightCall, fetchCall)
    }
}

extension TravelViewModel {
    enum State: Equatable {
        case loading,
             loaded,
             error(ErrorType)
    }
}
