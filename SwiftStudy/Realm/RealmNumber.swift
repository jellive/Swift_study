//
//  RealmNumber.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 7. 10..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import RealmSwift

class RealmNumber: Object {
    @objc var numberIndex: Int = 0
    @objc dynamic var date : NSDate!
    @objc var number: Int = 0
    
    
    override static func primaryKey() -> String {
        return "numberIndex"
    }
}
