//
//  File.swift
//  
//
//  Created by Enrico Maricar on 28/05/24.
//

import Foundation
import SwiftUI

public struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    public init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    public var body: some View {
        if let cached = ImageCache.shared[url] {
            return AnyView(content(.success(cached)))
        } else {
            return AnyView(
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction
                ) { phase in
                    cacheAndRender(phase: phase)
                }
            )
        }
    }

    public func cacheAndRender(phase: AsyncImagePhase) -> some View {
        switch phase {
        case .success(let image):
            DispatchQueue.main.async {
                ImageCache.shared[url] = image
            }
        case .failure(let error):
            print("Failed to load image for \(url): \(error.localizedDescription)")
        case .empty:
            print("Image request is empty for \(url)")
        @unknown default:
            print("Unknown phase for \(url)")
        }
        return content(phase)
    }
}

public class ImageCache {
    public static let shared = ImageCache()
    private var cache: [URL: Image] = [:]
    private let lock = DispatchQueue(label: "image.cache.lock")

    public subscript(url: URL) -> Image? {
        get {
            lock.sync {
                cache[url]
            }
        }
        set {
            lock.async(flags: .barrier) {
                self.cache[url] = newValue
            }
        }
    }
}
