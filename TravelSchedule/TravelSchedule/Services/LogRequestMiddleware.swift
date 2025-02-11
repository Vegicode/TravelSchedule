//
//  LogRequestMiddleware.swift
//  TravelSchedule
//
//  Created by Mac on 11.02.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes
import struct Foundation.URL

struct LogRequestMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        return try await next(request, body, baseURL)
    }
}
