//
//  UserDefaultsCityStorage.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import Foundation

protocol CityStorage {
    func save(city: String)
    func load() -> String?
}

final class UserDefaultsCityStorage: CityStorage {

    private let key = "last_city"

    func save(city: String) {
        UserDefaults.standard.set(city, forKey: key)
    }

    func load() -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
