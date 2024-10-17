//
//  ContactsDetailFeature.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/17/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct TCAContactDetailFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        let contact: TCAContact
    }
    enum Action {
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case deleteButtonTapped
        enum Alert {
          case confirmDeletion
        }
        enum Delegate {
          case confirmDeletion
        }
        
    }
    
    @Dependency(\.dismiss) var dismiss
      var body: some ReducerOf<Self> {
        Reduce { state, action in
          switch action {
          case .alert(.presented(.confirmDeletion)):
            return .run { send in
              await send(.delegate(.confirmDeletion))
              await self.dismiss()
            }
          case .alert:
            return .none
          case .delegate:
            return .none
          case .deleteButtonTapped:
            state.alert = .confirmDeletion
            return .none
          }
        }
        .ifLet(\.$alert, action: \.alert)
      }
    }


    extension AlertState where Action == TCAContactDetailFeature.Action.Alert {
      static let confirmDeletion = Self {
        TextState("Are you sure?")
      } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
          TextState("Delete")
        }
      }
    }
