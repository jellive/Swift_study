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

struct Issue_IssueTrackerModel {
    let provider: MoyaProvider<Issue_Github>
    let repositoryName: Observable<String>
    
//    func trackIssues() -> Observable<[Issue_Issue]> {
//        
//    }
//    
//    internal func findIssues(repository: Issue_Repository) -> Observable<[Issue_Issue]?> {
//        return self.provider.rx
//            .request(Issue_Github.issues(repositoryFullName: repository.fullName))
//            .debug()
//            .mapOptional(to: [Issue_Issue.self])
//    }
//    
//    internal func findRepository(name: String) -> Observable<Issue_Repository?> {
//        return self.provider
//        .reque
//        
//    }
}
