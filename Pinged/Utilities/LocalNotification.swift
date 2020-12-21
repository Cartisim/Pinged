//
//  LocalNotification.swift
//  Cartisim
//
//  Created by Cole M on 12/11/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotification {
    public static func newMessageNotification(title: String, subtitle: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: .none)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
            print(error as Any, "Local Notification Error")
           }
        }
    }
}
