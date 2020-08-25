//
//  RxMoyaGithubViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/08/02.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import Moya
import RxSwift

// MARK: - User struct.
struct RxMoyaGithubUser: Codable {
    let login: String
    let avatarUrl: String
    let reposUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}


// MARK: - Provider
enum provider {
    case userInfo(name: String)
}

extension provider: TargetType {
    var headers: [String: String]? {
        return nil
    }
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .userInfo(let name):
            return "/users/\(name)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var task: Task {
        return .requestPlain
    }
}

class RxMoyaGithubViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var getButton: UIButton!
    let name: BehaviorSubject<String> = BehaviorSubject(value: "")
    let nameValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let bag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func getButtonClicked(_ sender: Any) {
        if let name = try? name.value() {
            userInfo(name: name)
        }
    }
    
    // MARK: - Original Moya
//    func userInfo(name: String) {
//        let provider = MoyaProvider<provider>()
//        provider.request(.userInfo(name: name)) { result in
//            switch result {
//            case .success(let response):
//                guard let user = try? JSONDecoder().decode(RxMoyaGithubUser.self, from: response.data) else { return }
//                print(user.login)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    // MARK: - RxMoya
    func userInfo(name: String) {
        let provider = MoyaProvider<provider>()
        provider.rx.request(.userInfo(name: name))
            .map(RxMoyaGithubUser.self)
        .asObservable()
            .subscribe(onNext: {user in
                print(user.login)
                print(user.avatarUrl)
                print(user.reposUrl)
            }, onError: {error in
                print(error)
            }).disposed(by: bag)
    }
    
    func bindEvent() {
        userTextField.rx.text.orEmpty
            .bind(to: name)
        .disposed(by: bag)
        
        name.map(validName)
            .bind(to: nameValid)
            .disposed(by: bag)
        
        nameValid.subscribe(onNext: {[weak self] valid in
            self?.getButton.isEnabled = valid
            }).disposed(by: bag)
    }
    
    func validName(name: String) -> Bool {
        return !name.contains(" ")
    }
    
    
}

