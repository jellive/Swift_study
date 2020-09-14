//
//  RxSwiftSketchbookViewModel.swift
//  SwiftStudy
//
//  Created by YooHG on 9/14/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

// RxTodo already define in RxAlamofireViewModel.swift

//struct RxTodo: Codable, Identifiable {
//    public var id: Int
//    public var title: String
//    public var completed: Bool
//}


class RxSwiftSketchbookViewModel {
    var rxTodoArr: BehaviorSubject<[RxTodo]> = BehaviorSubject<[RxTodo]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        
    }
}
