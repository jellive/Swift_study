//
//  RealmTutorialViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/23/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var time: TimeInterval = Date().timeIntervalSinceReferenceDate
    
    //    override static func indexedProperties() -> [String] {
    //        return ["name"]
    //    }
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}

class RealmTutorialViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dogs: Results<Dog>!
    
    let bag = DisposeBag()
    
    lazy var dog: Dog = {
        let realm = try! Realm()
        let dog = Dog()
        try! realm.write {
            realm.add(dog)
        }
        return dog
    }()
    
    let config = Realm.Configuration(
        schemaVersion: 2,
        migrationBlock:  { migration, oldSchemaVersion in
            // 아무것도 안써도 대부분 알아서 마이그레이션 해줌.
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        dogs = realm.objects(Dog.self)
            .sorted(byKeyPath: "time", ascending: false)
        
        Observable.collection(from: dogs)
            .map ({"laps: \($0.count)"})
            .subscribe { event in
                self.title = event.element
        }
        .disposed(by: bag)
        
        
        
        
        
        
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")
        
        
        let puppies = realm.objects(Dog.self)
        //            .filter("age < 2")
        print(puppies.elements)
        print(puppies.count)
        
        try! realm.write {
            realm.add(myDog)
        }
        
        print(puppies.count)
        
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("age == 1").first
                try! realm.write {
                    theDog!.age = 3
                }
            }
        }
    }
}
