//
//  Issue_IssueTrackerModel.swift
//  SwiftStudy
//
//  Created by YooHG on 7/8/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct IssueTrackerModel {
    
//    let provider: MoyaProvider<Issue_GitHub>
//    let repositoryName: Observable<String>
//
//    func trackIssues() -> Observable<[Issue_Issue]> {
//        return repositoryName
//            .observeOn(MainScheduler.instance)
//            .flatMapLatest { name -> Observable<Issue_Repository?> in
//                print("Name: \(name)")
//                return self
//                    .findRepository(name)
//            }
//            .flatMapLatest { repository -> Observable<[Issue_Issue]?> in
//                guard let repository = repository else { return Observable.just(nil) }
//
//                print("Repository: \(repository.fullName)")
//                return self.findIssues(repository)
//            }
//            .replaceNilWith([])
//    }
//
//    internal func findIssues(_ repository: Issue_Repository) -> Observable<[Issue_Issue]?> {
//        return self.provider
//            .request(Issue_GitHub.issues(repositoryFullName: repository.fullName))
//            .debug()
//            .mapArrayOptional(type: Issue_Issue.self)
//    }
//
//    internal func findRepository(_ name: String) -> Observable<Issue_Repository?> {
//        return self.provider
//            .request(Issue_GitHub.repo(fullName: name))
//            .debug()
//            .mapObjectOptional(type: Issue_Repository.self)
//    }
}
