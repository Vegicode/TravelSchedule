
import Foundation

struct Schedule: Hashable, Identifiable {
    let id = UUID()
    let cities: [City]
    let stations: [Station]
    let destinations: [Destination]
    let routes: [Route]
    let carriers: [Carrier]
    
    init(
        cities: [City],
        stations: [Station],
        destinations: [Destination],
        routes: [Route],
        carriers: [Carrier]
    ) {
        self.cities = cities
        self.stations = stations
        self.destinations = destinations
        self.routes = routes
        self.carriers = carriers
    }
}
