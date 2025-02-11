//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by Mac on 11.02.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes
import struct Foundation.URL

struct AuthenticationMiddleware: ClientMiddleware {
    private let apikey: String

    init(apikey: String) {
        if apikey.isEmpty {
            assertionFailure("Specify the API access key.")
        }
        
        self.apikey = apikey
    }
    
    
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = "\(YandexAPIConfig.APIKEY)"
        
        return try await next(request, body, baseURL)
    }
   
}
