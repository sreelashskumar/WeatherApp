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

        image = nil 

        Task {
            if let cached = await ImageCache.shared.image(for: nsURL) {
                print("Loaded image from cache")
                self.image = cached
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    print("Failed to decode UIImage")
                    return
                }

                await ImageCache.shared.insert(image, for: nsURL)
                self.image = image
                print("Image loaded successfully")

            } catch {
                print("Image download error:", error)
            }
        }
    }
}

