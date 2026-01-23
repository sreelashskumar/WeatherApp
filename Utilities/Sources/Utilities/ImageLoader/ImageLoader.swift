//
//  ImageLoader.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import UIKit
import SwiftUI

@MainActor
public final class ImageLoader: ObservableObject {

    @Published public var image: UIImage?

    public init() {}

    public func load(from url: URL) {
        let nsURL = url as NSURL
        print("Start loading image:", url)

        Task {
            if let cached = await ImageCache.shared.image(for: nsURL) {
                print("Loaded image from cache")
                self.image = cached
                return
            }
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Image download error:", error)
                return
            }

            guard
                let data,
                let image = UIImage(data: data)
            else {
                print("Failed to decode UIImage")
                return
            }

            Task {
                await ImageCache.shared.insert(image, for: nsURL)
            }

            DispatchQueue.main.async {
                print("Image loaded successfully")
                self.image = image
            }
        }
        .resume()
    }
}
