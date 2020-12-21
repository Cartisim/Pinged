//
//  User.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: UUID?
    var fullName: String
    var email: String
    var isAdmin: Bool
    var updatedAt: String
    var createdAt: String
}

struct UserInput: Codable {
    var fullName: String
    var email: String
}

