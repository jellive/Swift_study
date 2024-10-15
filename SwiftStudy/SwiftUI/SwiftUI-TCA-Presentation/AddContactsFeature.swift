//
//  AddContactsFeature.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/15/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct AddContactsFeature {
    @ObservableState
    struct State: Equatable {
        var contact: TCAContact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none
                
            case .saveButtonTapped:
                return .none
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
