//
//  AppCoordinator.swift
//  Weather
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import UIKit
import Utilities
import WeatherFeature

final class AppCoordinator {

    private let window: UIWindow
    private let navigationController = AppNavigationController()
    private let configuration = AppConfiguration.live
    
    private var weatherCoordinator: WeatherCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    @MainActor func start() {
        let httpClient = URLSessionHTTPClient(
            host: configuration.weatherHost
        )
        
        let coordinator = WeatherCoordinator(
            navigationController: navigationController,
            httpClient: httpClient,
            apiKey: configuration.weatherAPIKey
        )

        self.weatherCoordinator = coordinator
        coordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
