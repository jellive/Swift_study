//
//  rxGithubViewModel.swift
//  SwiftStudy
//
//  Created by YooHG on 7/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import RxSwift
import RxCocoa

class RxGithubViewModel {
    let searchText = BehaviorRelay(value: "")
    
    //    lazy var data: Driver<[Repository]> = {
    //        return Observable.of([Repository]()).asDriver(onErrorJustReturn: [])
    //    }
    
    lazy var data: Driver<[Repository]> = {
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(RxGithubViewModel.repositoriesBy)
        .asDriver(onErrorJustReturn: [])
    }()
    
    static func repositoriesBy(_ githubID: String) -> Observable<[Repository]> {
        guard !githubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(githubID)/repos") else {
                return Observable.just([])
        }
        return URLSession.shared.rx.json(url: url)
            .retry(3)
            //        .catchErrorJustReturn()
            .map(parse)
    }
    
    static func parse(json: Any) -> [Repository] {
        guard let items = json as? [[String: Any]] else {
            return []
        }
        
        var repositories = [Repository]()
        
        items.forEach{
            guard let repoName = $0["name"] as? String,
                let repoURL = $0["html_url"] as? String else {return}
            repositories.append(Repository(repoName: repoName, repoURL: repoURL))
        }
        return repositories
    }
}
