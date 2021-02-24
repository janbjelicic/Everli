//
//  PostDTO.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation

struct PostDTO: Decodable {
    
    let identifier: Int
    let userID: Int
    let title: String
    let description: String
    let imageUrl: String
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case userID = "user_id"
        case title, description
        case imageUrl = "image"
        case publishedAt = "published_at"
    }
    
}
