//
//  UserChatSession.swift
//  Cartisim
//
//  Created by Cole M on 12/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct UserChatSession: Codable {
    var id: UUID?
    var fullName: String
    var chatSession: [ChatSession] = []
    var updatedAt: String?
    var createdAt: String?
    
}
