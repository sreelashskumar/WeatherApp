//
//  LocationService.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import CoreLocation

protocol LocationService: AnyObject {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func requestLocation()
}

final class DefaultLocationService: NSObject, LocationService, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onError: ((Error) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()

        case .denied, .restricted:
            onError?(CLError(.denied))

        @unknown default:
            onError?(CLError(.denied))
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            onError?(CLError(.denied))
        default:
            break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        onLocationUpdate?(location.coordinate)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        onError?(error)
    }
}
