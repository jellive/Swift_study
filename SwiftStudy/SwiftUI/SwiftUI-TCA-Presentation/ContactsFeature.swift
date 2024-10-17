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
        @Presents var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<TCAContact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactsFeature.Action>)
        case alert(PresentationAction<Alert>)
        case deleteButtonTapped(id: TCAContact.ID)
        enum Alert: Equatable {
            case confirmDeletion(id: TCAContact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactsFeature.State(contact: .init(id: UUID(), name: ""))
                return .none
                
//            case .addContact(.presented(.delegate(.cancel))):
//              state.addContact = nil
//              return .none
                
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
              state.contacts.append(contact)
//              state.addContact = nil
              return .none
                
            case .addContact:
                return .none
                
            case let .alert(.presented(.confirmDeletion(id: id))):
                state.contacts.remove(id: id)
                return .none
                
            case .alert:
                return .none
                
            case let .deleteButtonTapped(id: id):
                state.alert = AlertState {
                  TextState("Are you sure?")
                } actions: {
                  ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                    TextState("Delete")
                  }
                }
                return .none
            }
            
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactsFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
