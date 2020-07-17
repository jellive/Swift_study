//
//  SwiftUIAnimationView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUIAnimationView: View {
    @State private var startAnimation = false
    
    var body: some View {
        VStack {
            Button("Start Animation") {
                withAnimation(.easeInOut(duration: 4)) {
                    self.startAnimation.toggle()
                }
            }
            
            HStack {
                Spacer()
                Text("🚚")
                    .font(.custom("Arial", size: 100))
                    .offset(x: self.startAnimation ? 0 - UIScreen.main.bounds.width + 100: 0)
            }
        }
    }
}

struct SwiftUIAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAnimationView()
    }
}
