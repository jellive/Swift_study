//
//  RxSwiftSketchbookViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 9/9/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import RxSwift
import RxCocoa

class RxSwiftSketchbookViewController: UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        print("Hello world!")
        
        let a = Observable.just("a")
        
        a.subscribe(onNext: {print("onNext: \($0)")}, onError: {error in
            print("onError: \(error)")
        }, onCompleted: {
            print("onCompleted")
            
        }, onDisposed: {
            print("onDisposed")
        }).disposed(by: bag)
    }
}
