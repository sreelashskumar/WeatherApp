//
//  WeatherModel.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import Foundation

public struct WeatherModel: Codable, Sendable {
    public let coord: Coordinate
    public let weather: [WeatherCondition]
    public let main: MainWeather
    public let visibility: Int?
    public let wind: Wind?
    public let clouds: Clouds?
    public let sys: SystemInfo?
    public let timezone: Int?
    public let id: Int?
    public let name: String
    public let cod: Int
}

public struct Coordinate: Codable, Sendable {
    public let lon: Double
    public let lat: Double
}

public struct WeatherCondition: Codable, Sendable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct MainWeather: Codable, Sendable {
    public let temp: Double
    public let feelsLike: Double
    public let tempMin: Double
    public let tempMax: Double
    public let pressure: Int
    public let humidity: Int
    public let seaLevel: Int?
    public let groundLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
}

public struct Wind: Codable, Sendable {
    public let speed: Double
    public let deg: Int?
}

public struct Clouds: Codable, Sendable {
    public let all: Int
}

public struct SystemInfo: Codable, Sendable {
    public let country: String?
    public let sunrise: Int?
    public let sunset: Int?
}
