//
//  AppConfiguration.swift
//  Weather
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

struct AppConfiguration {
    let weatherHost: String
    let weatherAPIKey: String

    static let live = AppConfiguration(
        weatherHost: "api.openweathermap.org",
        weatherAPIKey: "b16522b9e1ca4e7d19391eb9ca0539c8"
    )
}
