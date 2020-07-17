//
//  SwiftUILocalPushView.swift
//  SwiftStudy
//
//  Created by YooHG on 7/17/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import SwiftUI

struct SwiftUILocalPushView: View {
    var body: some View {
        Button("Send Notification") {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("authorization granted")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Notification Tutorial"
            content.subtitle = "from iosCreator.com"
            content.body = " Notification triggered"
            content.sound = .default
            
            let imageName = "applelogo"
            guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
            
            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
            
            content.attachments = [attachment]
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
        }
    }
}

struct SwiftUILocalPushView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILocalPushView()
    }
}
