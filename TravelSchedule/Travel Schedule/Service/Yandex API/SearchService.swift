 
typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchServiceProtocol: Sendable {
    func getSearch(from: String, to: String) async throws -> SearchResponse
}

actor SearchService: SearchServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getSearch(from: String, to: String) async throws -> SearchResponse {
        let response = try await client.getSearch(query: .init(
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}
