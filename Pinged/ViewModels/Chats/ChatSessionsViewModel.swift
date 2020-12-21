//
//  ChatsViewModel.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class ChatSessions {
    
    var chatSessionsViewModel = [ChatSessionsViewModel]()
    
    struct ChatSessionsViewModel: Hashable {
        var identifier = NSUUID()
        var id: UUID?
        var contactID: String?
        var fullName: String
        var publicKey: String
        var createdAt: String?
        var updatedAt: String?
        
        init(chatSessions: ChatSession) {
            self.id = chatSessions.id
            self.contactID = chatSessions.contactID
            self.fullName = chatSessions.fullName
            self.publicKey = chatSessions.publicKey
            self.createdAt = chatSessions.createdAt
            self.updatedAt = chatSessions.updatedAt
        }
        
        
        static func == (lhs: ChatSessionsViewModel, rhs: ChatSessionsViewModel) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        func search(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return fullName.lowercased().contains(lowercasedFilter)
        }
        
        
        func requestChatSessionObject() -> ChatSessionRequest {
            let pk = self.publicKey
            return ChatSessionRequest(contactID: self.contactID ?? "", fullName: self.fullName, publicKey: pk)
        }
    }
    func searchChats(with filter: String?) -> [ChatSessionsViewModel] {
        return chatSessionsViewModel.filter ({ $0.search(filter)})
    }
    
}
