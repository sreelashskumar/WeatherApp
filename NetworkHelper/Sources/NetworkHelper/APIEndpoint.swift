//
//  APIEndpoint.swift
//  NetworkHelper
//
//  Created by NITHU THOMAS on 29/01/26.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}
