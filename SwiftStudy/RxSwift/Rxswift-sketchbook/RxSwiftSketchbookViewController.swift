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
    
    let behavior: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello world!")
        
        let z = 1
        
        let a = Observable.from(optional: z)
        
        
        a.subscribe(onNext: {
            print("onNext: \($0)")
        }, onError: {error in
            print("onError: \(error)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        }).disposed(by: bag)
        
        behavior.subscribe(onNext: {
            print("behavior: \($0)")
            }).disposed(by: bag)
        
        behavior.onNext(try! behavior.value() + 1)
        
        
        behavior.onNext(try! behavior.value() + 1)
        behavior.onNext(try! behavior.value() + 1)
        behavior.onNext(try! behavior.value() + 1)
        behavior.onNext(try! behavior.value() + 1)
        

//        a.bind(to: behavior).disposed(by: bag)
//
//        z = 100
        
        behavior.onNext(100)

    }
}
