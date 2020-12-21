//
//  NotificationName+Extension.swift
//  Cartisim
//
//  Created by Cole M on 6/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let connected = Notification.Name("connected")
    static let notConnected = Notification.Name("notConnected")
    static let confirmEmail = Notification.Name("confirmNotified")
    static let fetchCurrentUser = Notification.Name("currentUserNotified")
    static let registered = Notification.Name("registered")
    static let refreshFetchCurrentUser = Notification.Name("refreshFetchCurrentUser")
    static let refreshFetchUser = Notification.Name("refreshFetchUser")
    static let refreshFetchUsers = Notification.Name("refreshFetchUsers")
    static let refreshEagerUsers = Notification.Name("refreshEagerUsers")
    static let refreshEditUser = Notification.Name("refreshEditUser")
    static let refreshDeleteCurrentUser = Notification.Name("refreshDeleteCurrentUser")
    static let refreshDeleteSelectedUser = Notification.Name("refreshDeleteSelectedUser")
    static let logout = Notification.Name("logout")
    static let authenticate = Notification.Name("authenticate")
    static let refreshCreateInAppOrder = Notification.Name("refreshCreateInAppOrder")
    static let refreshSubscriptionCheck = Notification.Name("refreshSubscriptionCheck")
    static let refreshFetchChatSessions = Notification.Name("refreshfFetchChatSessions")
    static let refreshFetchUserChatSessions = Notification.Name("refreshFetchUserChatSessions")
    static let refreshFetchChatContactsl = Notification.Name("refreshFetchChatContactsl")
    static let refreshPostSenderKey = Notification.Name("refreshPostSenderKey")
    static let refreshFetchChatMessages = Notification.Name("refreshFetchChatMessages")
    static let sendAPNToken = Notification.Name("sendAPNToken")
    
    static let fetchChatSession = Notification.Name("fetchChatSession")
    static let setChatStatus = Notification.Name("setChatStatus")
    static let startObservingChatroom = Notification.Name("startObservingChatroom")
    static let clearChatroomData = Notification.Name("clearChatroomData")
    static let presentEditMessageSheet = Notification.Name("presentEditMessageSheet")
    static let queryChat = Notification.Name("queryChat")
    static let removeContacts = Notification.Name("removeContacts")
    static let removeChats = Notification.Name("removeChats")
    static let removeChatroom = Notification.Name("removeChatroom")
    
}

