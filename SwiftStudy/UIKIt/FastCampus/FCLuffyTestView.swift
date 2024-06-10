//
//  LuffyTestView.swift
//  SwiftStudy
//
//  Created by Jell PD on 2021/07/20.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import SwiftUI

struct FCLuffyTestView: View {
    @State var isPresented = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            isPresented = true
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }).alert(isPresented: $isPresented, content: {
            .init(title: Text("hi"), message: Text("message"), dismissButton: .default(Text("cancel")))
        })
    }
}

struct FCLuffyTestView_Previews: PreviewProvider {
    static var previews: some View {
        FCLuffyTestView()
    }
}
