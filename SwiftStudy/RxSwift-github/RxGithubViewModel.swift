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
    let searchText = BehaviorRelay<String>(value: "") // PublishRelay와 비슷하지만, 초기값을 갖는다는 차이가 있다. 얘는 안 죽음.
    // Observable에는 BehaviorSubject가 있다.
    
    //    lazy var data: Driver<[Repository]> = {
    //        return Observable.of([Repository]()).asDriver(onErrorJustReturn: [])
    //    }
    
    lazy var data: Driver<[Repository]> = { // lazy는 처음 사용되기 전까지는 연산이 되지 않는다. 이를테면 영상을 보려고 클릭하면 영상이 로드되는 용도로.
        // Driver는 RxSwift에만 있는 unit으로, 기본적으로 Observable을 사용하지만 UI Layer에서 더 직관적으로 사용하도록 제공하는 Unit임. Observable과의 차이는 MainScheduler와 BackgroundScheduler를 지정해줘야하는 Observable과 다르게 MainScheduler에서 사용한다는 점.
        return self.searchText.asObservable() // asObservable: Relay에서는 subscribe를 asObservable로 쓴다.
            // .completed나 .error를 받으면 종료된다.
//            .debounce(DispatchTimeInterval.milliseconds(30), scheduler: MainScheduler.instance) // throttle과의 차이는 지정한 시간 내에 마지막 하나의 이벤트만 전달한다.
            .throttle(0.3, scheduler: MainScheduler.instance) // throttle -> 타이머를 지정해두고 이벤트가 처음 방출되면 타이머 동안 어떤 이벤트도 방출되지 않는다. ex) 연속 클릭 방지
            // throttle은 latest라는 옵션이 있는데, 이는 재개될 떄 마지막으로 불린 observable을 출력할 지 여부를 뜻한다. scheduler 앞에 붙임.
            .distinctUntilChanged() // 이전 값과 비교해서 다른 값일 때에만 값을 흘려보낸다.
            .flatMapLatest(RxGithubViewModel.repositoriesBy) // flatMap은 Observable에서 발행한 아이템을 다른 Observable로 만들며, 만들어진 Observable에서 아이템을 발행한다. flatMap은 새로운 Observable을 관찰해도 그 전에 관찰했던 Observable들을 계속 관찰하고, flatMapLatest는 flatMap의 latest observable만 관찰한다. 마찬가지로 flatMapFirst는 새로운 Observable들로의 변환이 완료되기 전에는 새로 발행된 Observable은 무시하게 된다.
            .asDriver(onErrorJustReturn: [])
    }()
    
    static func repositoriesBy(_ githubID: String) -> Observable<[Repository]> {
        guard !githubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(githubID)/repos") else {
                return Observable.just([])
        }
        print("githubID: \(githubID)")
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
