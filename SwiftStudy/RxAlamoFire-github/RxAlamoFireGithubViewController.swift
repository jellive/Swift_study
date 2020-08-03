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

class RxAlamoFireGithubViewController: UIViewController {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var getButton: UIButton!
    let name: BehaviorSubject<String> = BehaviorSubject(value: "")
    let nameValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvent()
    }
    
    func bindEvent() {
        
        userTextField.rx.text.orEmpty
            .bind(to: name)
        .disposed(by: bag)
        
        name.map(validName)
            .bind(to: nameValid)
            .disposed(by: bag)
        
        
    }
    
    @IBAction func getButtonClicked(_ sender: Any) {
        RxAlamofire.requestData(.get, "https://api.github.com/users/\(name)")
            .flatMap{ (response, data) -> Observable<RxAlamoFireGithubUser> in
                do {
                    let user = try JSONDecoder().decode(RxAlamoFireGithubUser.self, from: data)
                    return Observable.just(user)
                } catch {
                    print("Error: \(error)")
                    return Observable.just(RxAlamoFireGithubUser(login: "", avatarUrl: "", reposUrl: ""))
                }
        }.subscribe(onNext: {
            print($0.login)
            print($0.avatarUrl)
            print($0.reposUrl)
            }).disposed(by: bag)
    }
    
    func validName(name: String) -> Bool {
        return !name.contains(" ")
    }
}
