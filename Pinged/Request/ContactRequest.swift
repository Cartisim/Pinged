//
//  ContactRequest.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct ContactRequest: Codable {
    var contactID: UUID?
    var fullName: String
    var publicKey: String
}
