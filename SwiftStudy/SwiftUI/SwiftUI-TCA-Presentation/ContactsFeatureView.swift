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
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.contacts) { contact in
                    NavigationLink(state: TCAContactDetailFeature.State(contact: contact)) {
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
                    }.buttonStyle(.borderless)
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
        } destination: { store in
            ContactDetailView(store: store)
        }
        .sheet(
            item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
        ) { addContactStore in
          NavigationStack {
              AddContactsFeatureView(store: addContactStore)
          }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
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
