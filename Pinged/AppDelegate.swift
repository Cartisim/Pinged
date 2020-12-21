//
//  AppDelegate.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var chatWindowController = ChatWindowController()
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NetworkMonitor.shared.networkMonitor()
        // Insert code here to initialize your application
//        KeychainItem.deleteKeyChainUserData()
        chatWindowController.showWindow(nil)
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("We got issues: \(error.localizedDescription)")
            } else {
                print("AUTHORIZED STATUS:", granted)
                DispatchQueue.main.async {
                    NSApplication.shared.registerForRemoteNotifications(matching: [.alert, .badge, .sound])
                    print("REGISTRATION STATUS:", NSApplication.shared.isRegisteredForRemoteNotifications)
                }
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

