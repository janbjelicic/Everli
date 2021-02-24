//
//  NetworkManager.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation

class NetworkManager {
    
    private let postsUrl = "http://www.mocky.io/v2/59f2e79c2f0000ae29542931"
    
    func getPosts(_ completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: postsUrl) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return
            }
            if response == nil {
                completion(.failure(APIError.invalidResponse))
                return
            }
            completion(self.parsePosts(data: data))
        }
        task.resume()
    }
    
    private func parsePosts(data: Data?) -> Result<[Post], Error> {
        guard let data = data else {
            return .failure(APIError.invalidResponse)
        }
        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let postObject = try JSONDecoder().decode(PostsObjectDTO.self, from: data)
            let posts = postObject.posts.map {
                Post(post: $0)
            }
            return .success(posts)
        } catch (let error) {
            return .failure(error)
        }
    }
    
}
