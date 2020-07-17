//
//  OO_Stopwatch.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class OO_Stopwatch: ObservableObject {
    @Published var counter: Int = 0
    
    var timer = Timer()
    
    func start() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.counter += 1
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func reset() {
        counter = 0
        timer.invalidate()
    }
}
