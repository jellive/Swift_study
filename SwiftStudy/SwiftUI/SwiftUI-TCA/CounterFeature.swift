//
//  CounterFeature.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/13/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import ComposableArchitecture
import Foundation


@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var numberFact: String?
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
          switch action {
          case .decrementButtonTapped:
            state.count -= 1
            return .none


          case .incrementButtonTapped:
            state.count += 1
            return .none


          case .numberFactButtonTapped:
            return .run { [count = state.count] send in
              let (data, _) = try await URLSession.shared.data(
                from: URL(string: "http://numbersapi.com/\(count)/trivia")!
              )
              await send(
                .numberFactResponse(String(decoding: data, as: UTF8.self))
              )
            }


          case let .numberFactResponse(fact):
            state.numberFact = fact
            return .none
          }
        }
      }
}
