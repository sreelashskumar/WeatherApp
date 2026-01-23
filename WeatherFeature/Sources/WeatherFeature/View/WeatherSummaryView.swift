//
//  WeatherSummaryView.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import SwiftUI

struct WeatherSummaryView: View {

    let weather: WeatherModel
    let onShowDetails: () -> Void

    var body: some View {
        VStack(spacing: 12) {

            Text(weather.name)
                .font(.title)

            Text("\(Int(weather.main.temp))°F")
                .font(.largeTitle)
                .bold()

            Text(weather.weather.first?.description.capitalized ?? "")
                .foregroundColor(.secondary)

            RemoteImageView(url: iconURL)
                .id(iconURL)
                .frame(width: 80, height: 80)

            Button("View Details") {
                onShowDetails()
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private var iconURL: URL? {
        guard let icon = weather.weather.first?.icon else { return nil }
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        print("Icon URL:", urlString)
        return URL(string: urlString)
    }
}
