//
//  SwiftUIObservableObjectView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUIObservableObjectView: View {
    
    @ObservedObject var stopwatch = OO_Stopwatch()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.stopwatch.start()
                }) {
                    Text("Start")
                }
                
                Button(action: { self.stopwatch.stop() },
                       label: { Text("Stop") })
                
                Button(action: {self.stopwatch.reset()}) {
                    Text("Reset")
                }
            }
            Text("\(self.stopwatch.counter)")
        }.font(.largeTitle)
    }
}

struct SwiftUIObservableObjectView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIObservableObjectView()
    }
}
