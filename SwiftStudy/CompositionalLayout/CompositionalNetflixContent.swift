//
//  CompositionalNetflixContent.swift
//  SwiftStudy
//
//  Created by HGYoo on 1/9/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import UIKit

struct CompositionalNetflixContent: Decodable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [CompositionalNetflixItem]
    
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct CompositionalNetflixItem: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? .init()
    }
}
