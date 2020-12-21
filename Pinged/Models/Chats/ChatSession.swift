//
//  ChatSession.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation
import CryptoKit

struct ChatSession: Codable {
    var id: UUID?
    var contactID: String?
    var fullName: String
    var publicKey: String
    var updatedAt: String?
    var createdAt: String?
}

struct ChatSessionData {
    
    static var shared = ChatSessionData()
    
    fileprivate var _chatSessionID = ""
    fileprivate var _chatSessionIDs = [""]
    fileprivate var _chatSymmetricKey: SymmetricKey? = nil
    fileprivate var _id = ""
    fileprivate var _chatSessionObject: ChatSessions.ChatSessionsViewModel? = nil
    
    var id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var chatSessionID: String {
        get {
            return _chatSessionID
        }
        set {
            _chatSessionID = newValue
        }
    }
    
    var chatSessionIDs: [String] {
        get {
            return _chatSessionIDs
        }
        set {
            _chatSessionIDs = newValue
        }
    }
    
    var chatSymmetricKey: SymmetricKey {
        get {
            return _chatSymmetricKey!
        }
        set {
            _chatSymmetricKey = newValue
        }
    }
    
    var chatSessionObject: ChatSessions.ChatSessionsViewModel {
        get {
            return _chatSessionObject!
        }
        set {
            _chatSessionObject = newValue
        }
    }
}
