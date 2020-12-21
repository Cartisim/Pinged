//
//  AuthData.swift
//  Cartisim
//
//  Created by Cole M on 11/14/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Auth: Codable {
    var accessToken: String?
    var refreshToken: String?
    var userID: String?
    var username: String?
    
    init(accessToken: String? = "", refreshToken: String? = "", userID: String? = "", username: String? = "") {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.userID = userID
        self.username = username
    }
}
