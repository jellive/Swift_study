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
        //        @Presents var addContact: AddContactsFeature.State?
        //        @Presents var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<TCAContact> = []
        @Presents var destination: Destination.State?
        var path = StackState<TCAContactDetailFeature.State>()
    }
    
    enum Action {
        case addButtonTapped
        //        case addContact(PresentationAction<AddContactsFeature.Action>)
        //        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        case deleteButtonTapped(id: TCAContact.ID)
        case path(StackAction<TCAContactDetailFeature.State, TCAContactDetailFeature.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: TCAContact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                //                state.addContact = AddContactsFeature.State(contact: .init(id: UUID(), name: ""))
                state.destination = .addContact(AddContactsFeature.State(contact: TCAContact(id: UUID(), name: "")))
                return .none
                
                //            case .addContact(.presented(.delegate(.cancel))):
                //              state.addContact = nil
                //              return .none
                //
                //            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                //              state.contacts.append(contact)
                ////              state.addContact = nil
                //              return .none
                //
                //            case .addContact:
                //                return .none
                //
                //            case let .alert(.presented(.confirmDeletion(id: id))):
                //                state.contacts.remove(id: id)
                //                return .none
                //
                //            case .alert:
                //                return .none
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                return .none
                
            case let .deleteButtonTapped(id: id):
                state.destination = .alert( AlertState {
                    TextState("Are you sure?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                        TextState("Delete")
                    }
                })
                return .none
                
            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
              guard let detailState = state.path[id: id]
              else { return .none }
              state.contacts.remove(id: detailState.contact.id)
              return .none
                
            case .path:
                return .none
            }
            
        }
        .ifLet(\.$destination, action: \.destination)
//        .ifLet(\.$addContact, action: \.addContact) {
//            AddContactsFeature()
//        }
//        .ifLet(\.$alert, action: \.alert)
        .forEach(\.path, action: \.path) {
            TCAContactDetailFeature()
        }
    }
}

extension TCAContactFeature {
    @Reducer
    enum Destination {
        case addContact(AddContactsFeature)
        case alert(AlertState<TCAContactFeature.Action.Alert>)
    }
}

extension TCAContactFeature.Destination.State: Equatable {
    
}
