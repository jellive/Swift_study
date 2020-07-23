//
//  RxAlamofireViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI
import RxSwift

struct RxAlamofireView: View {
    var viewModel: RxAlamofireViewModel = RxAlamofireViewModel()
    var disposeBag = DisposeBag()
    var todos = BehaviorSubject<[RxTodo]>(value:[])
    var resTodos: [RxTodo] = []
    
    init() {
        viewModel.rxTodoArr.subscribe(onNext: { res in
            print(res)
        }).disposed(by: disposeBag)
        viewModel.down(url: "https://jsonplaceholder.typicode.com/todos")
            .bind(to: self.todos)
            .disposed(by: disposeBag)
        todos.subscribe(onNext: { todo in
            self.resTodos = todo
            }).disposed(by: disposeBag)
    }
    
    var body: some View {
        VStack {
            
            Text("hi")
            //            Text("\(viewModel.rxTodoArr)")
            List(self.resTodos) {todo in
                VStack(alignment: .leading) {
                    Text(todo.title)
                    Text("\(todo.completed.description)")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    
}

struct RxAlamofireView_Previews: PreviewProvider {
    static var previews: some View {
        RxAlamofireView()
    }
}
