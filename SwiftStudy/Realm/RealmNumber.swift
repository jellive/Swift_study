//
//  RealmNumber.swift
//  SwiftStudy
//
//  Created by KLounge-HG on 2017. 7. 10..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import RealmSwift

class RealmNumber: Object {
    var numberIndex = 0
    dynamic var date : NSDate!
    var number = 0
    
    
    override static func primaryKey() -> String? {
        return "numberIndex"
    }
}
