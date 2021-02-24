//
//  AppManager.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation

/// Global super singleton, Apple isn't going away from this judging by their Environment property wrapper.
class AppManager {
    
    static let shared = AppManager()
    
    let imageManager: ImageManager
    let dateFormatter: PostsDateFormatter
    
    private init() {
        self.imageManager = ImageManager()
        self.dateFormatter = PostsDateFormatter()
    }
    
    
}
