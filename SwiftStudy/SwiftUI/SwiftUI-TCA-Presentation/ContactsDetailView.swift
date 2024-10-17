//
//  ContactDetailView.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/17/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
    @Bindable var store: StoreOf<TCAContactDetailFeature>
    
    var body: some View {
        Form {
            Button("Delete") {
              store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
  NavigationStack {
    ContactDetailView(
      store: Store(
        initialState: TCAContactDetailFeature.State(
          contact: TCAContact(id: UUID(), name: "Blob")
        )
      ) {
        TCAContactDetailFeature()
      }
    )
  }
}
