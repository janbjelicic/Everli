//
//  PostsDateFormatter.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import Foundation

struct PostsDateFormatter {
    
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func format(date: String) -> Date {
        // I would usually not force unwrap it but I got the answer from the recruiter that this is the only
        // data set on which the app would be tested on. In order to have a simple sort function and not to
        // switch back and forth between date type and string type I'm force unwrapping this.
        return dateFormatter.date(from: date)!
    }
    
}
