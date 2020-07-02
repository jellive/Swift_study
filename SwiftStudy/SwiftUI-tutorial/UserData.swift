//
//  UserData.swift
//  SwiftStudy
//
//  Created by YooHG on 6/30/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var profile = Profile.default
}
