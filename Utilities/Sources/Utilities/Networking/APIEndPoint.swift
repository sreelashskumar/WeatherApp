//
//  APIEndPoint.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import Foundation

public protocol APIEndpoint: Sendable {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

