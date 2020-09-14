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
    
    @IBOutlet var countLabel: UILabel!
    
    let vm = RxSwiftSketchbookViewModel()
    
    let behavior: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    let json: BehaviorSubject<[RxTodo]> = BehaviorSubject<[RxTodo]>(value: [])
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.countLabel.text = "\($0)"
            }).disposed(by: bag)
        
        behavior.onNext(100)
//        vm.down(url: "https://jsonplaceholder.typicode.com/todos")
//            .subscribe(onNext: {
//                print($0)
//            }).disposed(by: bag)
        
        json.asObserver().subscribe(onNext: { todo in
            print(todo)
            print("json is complete!")
            }).disposed(by: bag)

    }
    @IBAction func increaseBtnClicked(_ sender: Any) {
        behavior.onNext(try! behavior.value() + 1)
        vm.down(url: "https://jsonplaceholder.typicode.com/todos")
            .bind(to: json)
        .disposed(by: bag)
        behavior.onNext(try! behavior.value() + 1)
        vm.down(url: "https://jsonplaceholder.typicode.com/todos")
            .bind(to: json)
        .disposed(by: bag)
        behavior.onNext(try! behavior.value() + 1)
        vm.down(url: "https://jsonplaceholder.typicode.com/todos")
            .bind(to: json)
        .disposed(by: bag)
    }
}
