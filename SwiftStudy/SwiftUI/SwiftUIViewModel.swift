//
//  SwiftUIViewModel.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/06/28.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI
import Combine

class SwiftUIViewModel: ObservableObject, Identifiable {
    @Published var name = ""
    @Published var age: Int = 0
    @Published var height:Int = 0
    @Published var weight: Int = 0
    @Published var gender: Int = 0
    
    @Published var act: Int = 0
    
    var disposables = Set<AnyCancellable>()
    
    init(scheduler: DispatchQueue = DispatchQueue.main) {
        $gender
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveCompletion: {
              [weak self] value in
              guard let self = self else {return}
              switch value {
              case .failure: /// Promise.reject
                self.act = 0
              case .finished: /// Promise.then
                break
              }
            }, receiveValue: {
                [weak self] act in
                guard let self = self else {return}
                self.act = self.calculate(name: self.name, age: self.age, height: self.height, weight: self.weight, gender: self.gender, act: Double(self.act))
            })
                .store(in: &disposables)
    }
    
    
    func calculate(name: String, age: Int, height: Int, weight: Int, gender: Int, act: Double) -> Int {
        var before: Double = 0.0
        if gender == 0 {
            before = 66 + (13.7 * Double(weight))
            before = before + (5 * Double(height))
            before = before - (6.5 * Double(age))
        } else {
            before = 665 + (9.6 * Double(weight))
            before = before + (1.8 * Double(height))
            before = before - (4.7 * Double(age))
        }
        //        return before * act
        return Int(before)
    }
}
