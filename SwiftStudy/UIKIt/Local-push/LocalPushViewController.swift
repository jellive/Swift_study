//
//  LocalPushViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/07/05.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import UserNotifications

class LocalPushViewController: UIViewController {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        sendNotification(seconds: 5)
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "알림 테스트"
        notificationContent.body = "이것은 알림을 테스트 하는 것이다"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}

