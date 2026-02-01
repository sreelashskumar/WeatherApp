//
//  WeatherViewModel.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import Foundation
import Utilities

@MainActor
final class WeatherSearchViewModel: ObservableObject {

    @Published var city: String = ""
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var locationService: LocationService
    private let httpClient: URLSessionHTTPClient
    private let apiKey: String

    private let storage: CityStorage
    
    init(
        httpClient: URLSessionHTTPClient,
        apiKey: String,
        storage: CityStorage = UserDefaultsCityStorage(),
        locationService: LocationService = DefaultLocationService()
    ) {
        self.storage = storage
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.locationService = locationService
        
        if let savedCity = storage.load() {
            self.city = savedCity
            searchTapped()
        }
        
        setupLocation()
    }

    @MainActor
    func searchTapped() {
        guard !city.isEmpty else {
            errorMessage = "Please enter a city"
            return
        }

        isLoading = true

        let client = httpClient
        let city = self.city
        let apiKey = self.apiKey

        Task {
            do {
                let endpoint = WeatherEndpoint.city(
                    name: city,
                    apiKey: apiKey
                )

                print("Calling weather API for city:", city)
                
                let response: WeatherModel = try await client.request(
                    endpoint: endpoint,
                    responseType: WeatherModel.self
                )
                
                print("City API Success.", response)

                self.weather = response
                self.storage.save(city: self.city)
                self.isLoading = false
            } catch {
                print("API Error:", error)
                
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func fetchByLocation(lat: Double, lon: Double) {
        isLoading = true
        
        Task {
            do {
                let endpoint = WeatherEndpoint.coordinate(
                    lat: lat,
                    lon: lon,
                    apiKey: apiKey
                )

                let response: WeatherModel = try await httpClient.request(
                    endpoint: endpoint,
                    responseType: WeatherModel.self
                )
                
                print("Location API Success.", response)

                self.weather = response
                self.storage.save(city: response.name)
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func requestCurrentLocation() {
        locationService.requestLocation()
    }
    
    private func setupLocation() {
        locationService.onLocationUpdate = { [weak self] coord in
            self?.fetchByLocation(
                lat: coord.latitude,
                lon: coord.longitude
            )
        }

        locationService.onError = { error in
            print("Location error:", error)
        }
    }
}
