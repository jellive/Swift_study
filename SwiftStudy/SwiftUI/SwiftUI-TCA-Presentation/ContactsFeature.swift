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
        @Presents var addContact: AddContactsFeature.State?
        var contacts: IdentifiedArrayOf<TCAContact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactsFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactsFeature.State(contact: .init(id: UUID(), name: ""))
                return .none
                
            case .addContact(.presented(.cancelButtonTapped)):
              state.addContact = nil
              return .none
                
            case .addContact(.presented(.saveButtonTapped)):
              guard let contact = state.addContact?.contact
              else { return .none }
              state.contacts.append(contact)
              state.addContact = nil
              return .none
                
            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactsFeature()
        }
    }
}
