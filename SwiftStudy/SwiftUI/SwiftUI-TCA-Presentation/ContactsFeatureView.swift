//
//  ContactsFeatureView.swift
//  SwiftStudy
//
//  Created by Jell PD on 10/15/24.
//  Copyright © 2024 Jell PD. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContactsFeatureView: View {
    @Bindable var store: StoreOf<TCAContactFeature>
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    HStack {
                      Text(contact.name)
                      Spacer()
                      Button {
                        store.send(.deleteButtonTapped(id: contact.id))
                      } label: {
                        Image(systemName: "trash")
                          .foregroundColor(.red)
                      }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
        .sheet(
          item: $store.scope(state: \.addContact, action: \.addContact)
        ) { addContactStore in
          NavigationStack {
              AddContactsFeatureView(store: addContactStore)
          }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    ContactsFeatureView(
    store: Store(
        initialState: TCAContactFeature.State(
        contacts: [
            TCAContact(id: UUID(), name: "Blob"),
            TCAContact(id: UUID(), name: "Blob Jr"),
            TCAContact(id: UUID(), name: "Blob Sr"),
        ]
      )
    ) {
        TCAContactFeature()
    }
  )
}
