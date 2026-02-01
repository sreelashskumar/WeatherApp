//
//  WeatherEndPoint.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import Foundation
import Utilities

enum WeatherEndpoint {
    case city(name: String, apiKey: String)
    case coordinate(lat: Double, lon: Double, apiKey: String)
}

extension WeatherEndpoint: APIEndpoint {

    var path: String {
        "/data/2.5/weather"
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .city(let name, let apiKey):
            return [
                URLQueryItem(name: "q", value: name),
                URLQueryItem(name: "units", value: "imperial"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .coordinate(let lat, let lon, let apiKey):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "units", value: "imperial"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        }
    }

    var method: HTTPMethod {
        .get
    }
    
    var body: Data? {
        nil
    }
}
