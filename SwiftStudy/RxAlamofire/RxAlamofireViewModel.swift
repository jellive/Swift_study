//
//  RxAlamofireViewModel.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Foundation
//import Combine
import SwiftUI
import RxAlamofire
import RxSwift

struct RxTodo: Codable, Identifiable {
    public var id: Int
    public var title: String
    public var completed: Bool
}

class RxAlamofireViewModel {
    @Published var rxTodoArr: BehaviorSubject<[RxTodo]> = BehaviorSubject<[RxTodo]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        down(url: "https://jsonplaceholder.typicode.com/todos")
            .bind(to: rxTodoArr)
            .disposed(by: disposeBag)
//            .bind(to: rxTodoArr)
//            .disposed(by: disposeBag)
    }
    
    func down(url: String) -> Observable<[RxTodo]> {
        return RxAlamofire
            .requestData(.get, url)
            .flatMap{(response, data) -> Observable<[RxTodo]> in
                do {
                    
//                    guard let todoData = data else {
//                        print("No data")
//                        return Observable.just([])
//                    }
//                        let arr = try JSONDecoder().decode([Todo].self, from: todoData)
//                    let todoArr = try JSONSerialization.jsonObject(with: data, options: []) as! [RxTodo]
                    let todoArr = try JSONDecoder().decode([RxTodo].self, from: data)
//                    self.rxTodoArr = todoArr
                    return Observable.just(todoArr)
                    
                } catch {
                    print("Error: \(error)")
                    return Observable.just([])
//                    self.rxTodoArr = []
                }
        }
    }
}
