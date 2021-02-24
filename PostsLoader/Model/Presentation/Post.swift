//
//  Post.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation
import UIKit

struct Post {
    
    let identifier: Int
    let title: String
    let description: String
    var imageUrl: String
    let publishedAt: String
    
    init(post: PostDTO) {
        self.identifier = post.identifier
        self.title = post.title
        self.description = post.description
        self.imageUrl = post.imageUrl
        self.publishedAt = post.publishedAt
    }
    
}
