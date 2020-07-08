//
//  CircleViewModel.swift
//  SwiftStudy
//
//  Created by YooHG on 7/8/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import ChameleonFramework
import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
    var centerVariable = BehaviorRelay<CGPoint?>(value: .zero) // 관찰할 변수, Observer와 Observable을 둘 다 쓰기 때문에 Variable로 둬야 함. Variable은 BehaviorRelay
    var backgroundColorObservable: Observable<UIColor>! // 관찰할 변수, 다른 것들에 영향을 주지 않기 때문에 Observable로 두면 됨.
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable()
            .map{ center in
                guard let center = center else { return UIColor.flatten(.black)() } // flatten은 chameleonframework에 있는 거다.
                let red: CGFloat = (center.x + center.y).truncatingRemainder(dividingBy: 255.0) / 255.0 // Int가 아닌 수 끼리는 truncatingRemainder를 써야 함.
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
        }
    }
}
