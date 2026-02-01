//
//  RemoteImageView.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import SwiftUI
import Utilities

struct RemoteImageView: View {

    let url: URL?

    @StateObject private var loader = ImageLoader()

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Color.clear
            }
        }
        .frame(width: 80, height: 80)
        .task(id: url) {
            guard let url else {
                print("Icon URL is nil")
                return
            }
            loader.load(from: url)
        }
    }
}

