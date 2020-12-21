//
//  ChatroomViewModel.swift
//  Cartisim
//
//  Created by Cole M on 12/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Chatrooms {
    
    var chatroomViewModel = [ChatroomViewModel]()
    
    struct ChatroomViewModel: Hashable {
        var id: UUID?
        var avatar: String
        var contactID: String?
        var fullName: String
        var message: String
        var token: String?
        var sessionID: String?
        var createdAt: String?
        var updatedAt: String?
        
        init(chatroom: Chatroom) {
            self.id = chatroom.id
            self.avatar = chatroom.avatar
            self.contactID = chatroom.contactID
            self.fullName = chatroom.fullName
            self.message = chatroom.message
            self.sessionID = chatroom.sessionID
            self.createdAt = chatroom.createdAt
            self.updatedAt = chatroom.updatedAt
        }
        
        static func == (lhs: ChatroomViewModel, rhs:  ChatroomViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        func search(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            let decryptedMessage = Crypto.shared.decryptText(text: message, symmetricKey: ChatSessionData.shared.chatSymmetricKey).lowercased()
            return decryptedMessage.contains(lowercasedFilter)
        }
        func requestChatroomObject() -> ChatroomRequest {
            return ChatroomRequest(avatar: self.avatar, contactID: self.contactID ?? "", fullName: self.fullName,  message: self.message, token: self.token ?? "", sessionID: self.sessionID ?? "", chatSessionID: self.id!.uuidString)
        }
    }
    func searchMessages(with filter: String?) -> [ChatroomViewModel] {
        return chatroomViewModel.filter ({ $0.search(filter)})
    }

}
