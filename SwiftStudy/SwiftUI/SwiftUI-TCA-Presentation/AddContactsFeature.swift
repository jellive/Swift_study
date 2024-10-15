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
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        enum Delegate: Equatable {
//            case cancel
            case saveContact(TCAContact)
        }
    }
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run{ _ in await self.dismiss() }
                
            case .saveButtonTapped:
                return .run {[contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case .delegate(_):
                return .none
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
