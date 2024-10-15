//
//  CounterFeatureView.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/13/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeatureView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        Form {
            Section {
                Text("\(store.count)")
                Button("Decrement") {store.send(.decrementButtonTapped)}
                Button("Increment") {store.send(.incrementButtonTapped)}
            }
            
            Section {
                Button("Number fact") { store.send(.numberFactButtonTapped)}
            }
            
            Section {
                Button(store.isTimerRunning ? "Stop timer:\(String(describing: store.isTimerRunning))": "Start timer:\(String(describing: store.isTimerRunning))") {
                    store.send(.toggleTimerButtonTapped)
                }
            }
            
            if let fact = store.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    CounterFeatureView(store: Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    })
}
