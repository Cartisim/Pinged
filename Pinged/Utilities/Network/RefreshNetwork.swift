//
//  RefreshNetwork.swift
//  Cartisim
//
//  Created by Cole M on 11/3/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class RefreshNetwork: NSObject {
    static let shared = RefreshNetwork()
    func refreshNetworkTriggered(key: String) {
        DispatchQueue.main.async {
            switch key {
            case NetworkCall.currentUser.rawValue:
                NotificationCenter.default.post(name: .refreshFetchCurrentUser, object: nil)
            case NetworkCall.user.rawValue:
                NotificationCenter.default.post(name: .refreshFetchUser, object: nil)
            case NetworkCall.users.rawValue:
                NotificationCenter.default.post(name: .refreshFetchUsers, object: nil)
            case NetworkCall.deleteCurrentUser.rawValue:
                NotificationCenter.default.post(name: .refreshDeleteCurrentUser, object: nil)
            case NetworkCall.fetchChatSessions.rawValue:
                NotificationCenter.default.post(name: .refreshFetchChatSessions, object: nil)
            case NetworkCall.fetchUserChatSessions.rawValue:
                NotificationCenter.default.post(name: .refreshFetchUserChatSessions, object: nil)
            case NetworkCall.fetchChatContacts.rawValue:
                NotificationCenter.default.post(name: .refreshFetchChatContactsl, object: nil)
            case NetworkCall.postSenderKey.rawValue:
                NotificationCenter.default.post(name: .refreshPostSenderKey, object: nil)
            case NetworkCall.fetchChatMessages.rawValue:
                NotificationCenter.default.post(name: .refreshFetchChatMessages, object: nil)
                
            default:
                break
            }
        }
    }
}
