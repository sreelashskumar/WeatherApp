//
//  ImageCache.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import UIKit

actor ImageCache {

    static let shared = ImageCache()

    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: NSURL) -> UIImage? {
        cache.object(forKey: url)
    }

    func insert(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
