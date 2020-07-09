//
//  Issue_Repository.swift
//  SwiftStudy
//
//  Created by YooHG on 7/8/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import Mapper

struct Issue_Repository: Mappable {
    
    let identifier: Int
    let language: String
    let name: String
    let fullName: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        try fullName = map.from("full_name")
    }
}
