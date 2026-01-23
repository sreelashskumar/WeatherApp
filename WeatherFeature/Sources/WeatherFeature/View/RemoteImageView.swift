//
//  RemoteImageView.swift
//  WeatherFeature
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import SwiftUI
import Utilities

struct RemoteImageView: View {

    @ObservedObject private var loader: ImageLoader
    let url: URL?

    init(url: URL?) {
        self.url = url
        self.loader = ImageLoader()
    }

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
        .onAppear {
            print("RemoteImageView appeared")
            if let url {
                loader.load(from: url)
            } else {
                print("Icon URL is nil")
            }
        }
    }
}
