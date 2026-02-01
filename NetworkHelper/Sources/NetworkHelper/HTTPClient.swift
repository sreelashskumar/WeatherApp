//
//  HTTPClient.swift
//  NetworkHelper
//
//  Created by NITHU THOMAS on 29/01/26.
//

protocol HTTPClient {
    func fetch<Response: Decodable>(endpoint: APIEndpoint, decodeType: Response.Type)
}
