//
//  ChatroomRequest.swift
//  Cartisim
//
//  Created by Cole M on 12/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct ChatroomRequest: Codable {
    var avatar: String
    var contactID: String
    var fullName: String
    var message: String
    var token: String
    var sessionID: String
    var chatSessionID: String
}

struct SessionID: Codable {
    var chatSessionID: String
    var token: String
}
