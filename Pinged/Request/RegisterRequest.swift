//
//  RegisterRequest.swift
//  Cartisim
//
//  Created by Cole M on 6/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    var fullName: String
    var email: String
    var password: String
    var confirmPassword: String
}
