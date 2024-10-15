//
//  ContactsFeature.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/15/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct TCAContact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct TCAContactFeature {
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<TCAContact> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                return .none
            }
        }
    }
}
