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
    
    init() {
        viewModel.rxTodoArr.subscribe(onNext: { todo in
            print(todo)
        }).disposed(by: disposeBag)
    }
    
    var body: some View {
        VStack {
            
            Text("hi")
            //            Text("\(viewModel.rxTodoArr)")
        }
    }
    
    
}

struct RxAlamofireView_Previews: PreviewProvider {
    static var previews: some View {
        RxAlamofireView()
    }
}
