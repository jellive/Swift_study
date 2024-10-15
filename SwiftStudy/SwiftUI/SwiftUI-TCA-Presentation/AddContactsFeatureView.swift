//
//  AddContactsFeatureView.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/15/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AddContactsFeatureView: View {
    @Bindable var store: StoreOf<AddContactsFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactsFeatureView(
        store: Store(
            initialState: AddContactsFeature.State(
            contact: TCAContact(
              id: UUID(),
              name: "Blob"
            )
          )
        ) {
            AddContactsFeature()
        }
      )
    }
}
