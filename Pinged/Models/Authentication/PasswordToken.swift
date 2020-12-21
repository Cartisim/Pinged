//
//  PasswordToken.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct PasswordToken: Codable {
    
    var id: UUID?
    var accessToken: String
    var refreshToken: String
    var user: User?
}

struct SIWAToken: Codable {
    
    var id: UUID?
    var accessToken: String
    var refreshToken: String
}
