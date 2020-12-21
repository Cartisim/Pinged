//
//  ChatsRequest.swift
//  Cartisim
//
//  Created by Cole M on 11/30/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct ChatSessionRequest: Codable {
    var contactID: String
    var fullName: String
    var publicKey: String
}
