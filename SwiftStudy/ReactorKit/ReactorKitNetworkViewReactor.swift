//
//  ReactorKitNetworkViewReactor.swift
//  SwiftStudy
//
//  Created by HGYoo-visualsyn on 2022/11/17.
//  Copyright © 2022 Jell PD. All rights reserved.
//

import ReactorKit
import RxSwift

final class ReactorKitCounterNetworkReactor: Reactor {
    enum Action {
        case test
    }
    
    enum Mutation {
        case testValue
    }
    
    struct State {
        var value = 0
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        return Observable.just(Mutation.testValue)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .testValue:
            newState.value = 3
        }
        return newState
    }
    
}
