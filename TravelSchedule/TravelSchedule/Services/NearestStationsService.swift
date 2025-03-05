//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Mac on 04.02.2025.
//


typealias NearestStations = Components.Schemas.NearestStationsResponse


protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance))
        return try response.ok.body.json
    }
    
    
}
