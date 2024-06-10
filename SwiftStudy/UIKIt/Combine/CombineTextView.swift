//
//  CombineTextView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct CombineTextView: View {
    @State var hello: String
    
    var body: some View {
        Text(hello)
    }
}

struct CombineTextView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTextView(hello: "hello, world")
    }
}
