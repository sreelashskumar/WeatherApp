//
//  HTTPClient.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import Foundation

public protocol HTTPClient {
    func request<Response: Decodable & Sendable>(
        endpoint: APIEndpoint,
        responseType: Response.Type
    ) async throws -> Response
}
