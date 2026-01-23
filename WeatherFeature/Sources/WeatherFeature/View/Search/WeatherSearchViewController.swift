//
//  WeatherSearchViewController.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import UIKit
import SwiftUI

final class WeatherSearchViewController: UIViewController {

    private let onShowDetails: () -> Void
    private let viewModel: WeatherSearchViewModel

    init(
        viewModel: WeatherSearchViewModel,
        onShowDetails: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onShowDetails = onShowDetails
        super.init(nibName: nil, bundle: nil)
        title = "Weather"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let swiftUIView = WeatherSearchView(
            viewModel: viewModel,
            onShowDetails: onShowDetails
        )

        let hosting = UIHostingController(rootView: swiftUIView)

        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)

        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hosting.didMove(toParent: self)
    }
}

