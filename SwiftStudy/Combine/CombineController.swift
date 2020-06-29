//
//  CombineController.swift
//  SwiftStudy
//
//  Created by YooHG on 6/22/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Foundation
import Combine

class CustomSubscriber: Subscriber {
    func receive(completion: Subscribers.Completion<Failure>) {
        print("모든 데이터의 발행이 완료되었습니다.")
    }
    
    func receive(subscription: Subscription) {
        print("데이터의 구독을 시작합니다.")
        subscription.request(.unlimited)
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("데이터를 받았습니다.", input)
        return .none
    }
    
    typealias Input = String ///  성공타입
    typealias Failure = Never /// 실패타입
}


let publisher = ["A", "B", "C", "D", "E", "F", "G"].publisher

let subscriber = CustomSubscriber()

publisher.subscribe(subscriber)
