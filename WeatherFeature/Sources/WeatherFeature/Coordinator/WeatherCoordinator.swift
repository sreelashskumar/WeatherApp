//
//  WeatherCoordinator.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import UIKit
import Utilities

@MainActor
public final class WeatherCoordinator {

    private let navigationController: UINavigationController
    private let httpClient: URLSessionHTTPClient
    private let apiKey: String

    public init(
        navigationController: UINavigationController,
        httpClient: URLSessionHTTPClient,
        apiKey: String
    ) {
        self.navigationController = navigationController
        self.httpClient = httpClient
        self.apiKey = apiKey
    }

    public func start() {
        showSearch()
    }

    private func showSearch() {
        let viewModel = WeatherSearchViewModel(
            httpClient: httpClient,
            apiKey: apiKey
        )

        let vc = WeatherSearchViewController(
            viewModel: viewModel,
            onShowDetails: { [weak self] in
                self?.showDetails()
            }
        )

        navigationController.setViewControllers([vc], animated: false)
    }

    private func showDetails() {
        navigationController.pushViewController(
            WeatherDetailsViewController(),
            animated: true
        )
    }
}
