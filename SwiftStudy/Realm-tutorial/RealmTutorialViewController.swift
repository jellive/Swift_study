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

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}

class RealmTutorialViewController: UIViewController {
    override func viewDidLoad() {
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")
        
        let realm = try! Realm()
        
        let puppies = realm.objects(Dog.self).filter("age < 2")
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
