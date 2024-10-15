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
        var isTimerRunning = false
        var fact: String?
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
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
              
          case .timerTick:
              state.count += 1
              state.fact = nil
              return .none
              
          case .toggleTimerButtonTapped:
              state.isTimerRunning.toggle()
              if state.isTimerRunning {
                  return .run { send in
                      while true {
                          try await Task.sleep(for: .seconds(1))
                          await send(.timerTick)
                      }
                  }
                  .cancellable(id: CancelID.timer)
              } else {
                  return .cancel(id: CancelID.timer)
              }
          }
            
        }
      }
}
