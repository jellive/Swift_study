//
//  CounterFeature.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/13/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct Feature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var numberFact: String?
    }
}
