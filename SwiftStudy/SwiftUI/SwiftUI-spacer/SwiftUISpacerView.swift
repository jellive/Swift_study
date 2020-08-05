//
//  SwiftUISpacerView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUISpacerView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "1.circle.fill")
                Image(systemName: "arrow.left.circle.fill")
                Spacer()
            }.padding()
            
            Spacer()
            
            HStack {
                Image(systemName: "arrow.left.circle.fill")
                Spacer()
                Image(systemName: "2.circle.fill")
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
            }.padding()
            
            Spacer()
            
            HStack {
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                Image(systemName: "3.circle.fill")
            }.padding()
        }
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.blue)
        .font(.largeTitle)
        .padding()
        .frame(width: 400, height: 400)
    }
}

struct SwiftUISpacerView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUISpacerView()
    }
}
