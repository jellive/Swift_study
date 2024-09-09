//
//  MainViewModel.swift
//  weekly_widget
//
//  Created by Jell PD on 9/9/24.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var day = "Mon"
    
    @Published var text = "day text"
    
    func search() {
        guard day.isEmpty else { return text = "Please enter text"}
        
        
    }
    
    
    func setUserDefaults(name value: String, key: String) {
        UserDefaults.shared.set(value, forKey: key)
        UserDefaults.shared.synchronize()
    }
    
    func getUserDefaults(_ key: String) -> String? {
        return UserDefaults.shared.string(forKey: key)
    }
}
struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String?
}
