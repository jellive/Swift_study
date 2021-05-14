//
//  CounterViewReactor.swift
//  SwiftStudy
//
//  Created by YooHG on 2021/05/14.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import ReactorKit
import RxSwift

final class ReactorKitCounterViewReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increateValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value = 0
        var isLoading = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increateValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .increateValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading): // 원문은 let이 빠져있음.
            newState.isLoading = isLoading
        }
        return newState
    }
    
    
}
