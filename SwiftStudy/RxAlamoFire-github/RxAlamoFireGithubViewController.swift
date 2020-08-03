//
//  RxAlamoFireGithubViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 8/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

// MARK: - User struct.
struct RxAlamoFireGithubUser: Codable {
    let login: String
    let avatarUrl: String
    let reposUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}

class RxAlamoFireGithubVIewController: UIViewController {
    
}
