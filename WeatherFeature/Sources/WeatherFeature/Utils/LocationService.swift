//
//  LocationService.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import Foundation
import CoreLocation

@MainActor
protocol LocationService: AnyObject {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func requestLocation()
}

@MainActor
final class DefaultLocationService: NSObject, LocationService, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onError: ((Error) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        print("requestLocation() called")
        print("Bundle:", Bundle.main.bundleIdentifier ?? "nil")
        print("Plist value:",
              Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") ?? "MISSING")
        
        let status = manager.authorizationStatus
        print("Auth status:", status)
        
        switch status {
        case .notDetermined:
            print("Asking for permission")
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            print("Requesting location")
            manager.requestLocation()
            
        case .denied, .restricted:
            print("Permission denied")
            onError?(CLError(.denied))
            
        @unknown default:
            onError?(CLError(.denied))
        }
    }

    // MARK: - CLLocationManagerDelegate

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus

        Task { @MainActor in
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                self.manager.requestLocation()
            case .denied, .restricted:
                self.onError?(CLError(.denied))
            default:
                break
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager,
                                     didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        Task { @MainActor in
            self.onLocationUpdate?(location.coordinate)
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager,
                                     didFailWithError error: Error) {
        Task { @MainActor in
            self.onError?(error)
        }
    }

}

