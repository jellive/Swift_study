//
//  SecondSwiftUIView.swift
//  SwiftStudy
//
//  Created by YooHG on 6/18/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SecondSwiftUIView: View {
    @Binding var touchedCount: Int
    var body: some View {
        NavigationView {
//            Text("This is second View")
            Text("\(touchedCount)")
        }
    }
}

struct SecondSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSwiftUIView(touchedCount: Binding.constant(1))
    }
}
