//
//  ImageManager.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation
import UIKit

class ImageManager {
    
    /// In memory cache for loaded images.
    private var loadedImages = [Int: UIImage]()
    
    /// Requests that are currently running distingueshed by an ID so that can be fetched or cancelled at any time.
    private var requests = [UUID: URLSessionDataTask]()
    
    func loadImage(from urlPath: String, id: Int, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        guard let url = URL(string: urlPath) else { return nil }
        if let image = loadedImages[id] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            // Remove this request from the current ones when the closure gets executed.
            defer {
                self.requests.removeValue(forKey: uuid)
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[id] = image
                completion(.success(image))
                return
            }
        }
        task.resume()
        requests[uuid] = task
        return uuid
    }
    
    /// Cancel loading a specific image.
    func cancelImageLoad(_ uuid: UUID) {
        requests[uuid]?.cancel()
        requests.removeValue(forKey: uuid)
    }
    
    func clearCache() {
        loadedImages = [Int: UIImage]()
        for request in requests {
            request.value.cancel()
        }
        requests = [UUID: URLSessionDataTask]()
    }
    
}
