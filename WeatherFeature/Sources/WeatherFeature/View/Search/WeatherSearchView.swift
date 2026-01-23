//
//  WeatherSearchView.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 22/01/26.
//

import SwiftUI

struct WeatherSearchView: View {

    @ObservedObject var viewModel: WeatherSearchViewModel
    let onShowDetails: () -> Void

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                portraitLayout
            } else {
                landscapeLayout
            }
        }
        .padding()
    }
    
    private var portraitLayout: some View {
        VStack(spacing: 20) {
            searchControls
            resultSection
            Spacer()
        }
    }

    private var landscapeLayout: some View {
        HStack(spacing: 20) {
            VStack {
                searchControls
                Spacer()
            }
            Divider()
            resultSection
            Spacer()
        }
    }

    private var searchControls: some View {
        VStack(spacing: 12) {
            TextField("Enter city", text: $viewModel.city)
                .textFieldStyle(.roundedBorder)

            Button("Search") {
                viewModel.searchTapped()
            }
            
            Button("Use Current Location") {
                viewModel.requestCurrentLocation()
            }
        }
    }

    private var resultSection: some View {
        Group {
            if viewModel.isLoading {
//                ProgressView()
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            if let weather = viewModel.weather {
                WeatherSummaryView(
                    weather: weather,
                    onShowDetails: onShowDetails
                )
            }
        }
    }
}
