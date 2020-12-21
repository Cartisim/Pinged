//
//  Chatroom.swift
//  Cartisim
//
//  Created by Cole M on 12/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct Chatroom: Codable {
    var id: UUID?
    var avatar: String
    var contactID: String?
    var fullName: String
    var message: String
    var token: String?
    var sessionID: String?
    var createdAt: String?
    var updatedAt: String?
}

struct ChatroomData {
    
    static var shared = ChatroomData()
    
    fileprivate var _chatroomID = ""
    fileprivate var _messageID = ""
    fileprivate var _chatObject: Chatrooms.ChatroomViewModel? = nil
    
    var messageID: String {
        get {
            return _messageID
        }
        set {
            _messageID = newValue
        }
    }
    
    var chatroomObject: Chatrooms.ChatroomViewModel {
        get {
            return _chatObject!
        }
        set {
            _chatObject = newValue
        }
    }
}
