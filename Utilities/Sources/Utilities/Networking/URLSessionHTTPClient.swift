//
//  URLSessionHTTPClient.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import Foundation

public actor URLSessionHTTPClient: HTTPClient {
    
    private let host: String
    
    public init(host: String) {
        self.host = host
    }
    
    public func request<Response: Decodable  & Sendable>(
        endpoint: APIEndpoint,
        responseType: Response.Type
    ) async throws -> Response {

        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
//        guard let url = URL(string: endpoint.path) else {
//            throw HttpError.invalidURL
//        }
        
        guard let url = components.url else {
            throw HttpError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        var httpMethod = endpoint.method.rawValue
        
//        if let parameters = endpoint.parameters {
//            let data = try JSONSerialization.data(withJSONObject: parameters)
//            urlRequest.httpBody = data
//        }
        
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = endpoint.body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw HttpError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpError.unknownError
        }
        
        let statusCode = httpResponse.statusCode
        
        guard (200...299).contains(statusCode) else {
            throw HttpError.serverError(statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(responseType, from: data)
            
            return decodedObject
        }
        catch {
            throw HttpError.decodeError(error)
        }
    }
}
