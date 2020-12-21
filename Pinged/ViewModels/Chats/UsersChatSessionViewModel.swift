//
//  UsersChatSessionViewModel.swift
//  Cartisim
//
//  Created by Cole M on 12/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation


class UserChatSessions {
    
    var userChatSessionsViewModel = [UserChatSessionsViewModel]()
    
    class UserChatSessionsViewModel: Hashable {
        var identifier = NSUUID()
        var id: UUID?
        var fullName: String
        var chatSession: [ChatSession]
        var updatedAt: String?
        var createdAt: String?
        
        init(user: UserChatSession) {
            self.id = user.id
            self.fullName = user.fullName
            self.chatSession = user.chatSession
            self.updatedAt = user.updatedAt
            self.createdAt = user.createdAt
        }
        
        static func == (lhs: UserChatSessionsViewModel, rhs: UserChatSessionsViewModel) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
}
