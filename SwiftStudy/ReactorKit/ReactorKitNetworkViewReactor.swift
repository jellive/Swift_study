//
//  ReactorKitNetworkViewReactor.swift
//  SwiftStudy
//
//  Created by HGYoo-visualsyn on 2022/11/17.
//  Copyright © 2022 Jell PD. All rights reserved.
//

import ReactorKit
import RxSwift
import Moya
import RxMoya
import Foundation

final class ReactorKitNetworkReactor: Reactor {
    let provider = MoyaProvider<rxMoyaResourceProvider>()
    let disposeBag = DisposeBag()
    
    enum Action {
        case get
    }
    
    enum Mutation {
        case getValue(RxMoyaResource)
    }
    
    struct State {
        var resource: RxMoyaResource?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) async -> Observable<Mutation> {
        switch action {
        case .get:
            let resource = try! await provider.rx
                .request(.listResource)
                .map(RxMoyaResource.self).value
            return Observable.concat([
                Observable.just(Mutation.getValue(resource))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .getValue(let resource):
            newState.resource = resource
        }
        return newState
    }
    
}


// MARK: - User struct.
struct ReactorKitNetworkType: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [RxMoyaResource]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

struct RxMoyaResource: Codable {
    let id: Int
    let name: String
    let year: Int
    let color: String
    let pantoneValue: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case year
        case color
        case pantoneValue = "pantone_value"
    }
}

// MARK: - Provider
enum rxMoyaResourceProvider {
    case listResource
}

extension rxMoyaResourceProvider: TargetType {
    var headers: [String: String]? {
        return nil
    }
    var baseURL: URL {
        return URL(string: "https://reqres.in/")!
    }
    
    var path: String {
        switch self {
        case .listResource: // enum의 영향을 받음.
            return "/api/unknown"
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
