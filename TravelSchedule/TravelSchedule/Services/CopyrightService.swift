//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Mac on 11.02.2025.
//

typealias CopyrightResponse = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightResponse
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getCopyright() async throws -> CopyrightResponse {
        let response = try await client.getCopyright()
        
        return try response.ok.body.json
    }
}

