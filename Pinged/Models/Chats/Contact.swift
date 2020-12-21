//
//  Contact.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct Contact: Codable {
    var id: UUID?
    var fullName: String
    var publicKey: String?
    var createdAt: String?
    var updatedAt: String?
}

struct ContactData {
    
    static var shared = ContactData()
    
    fileprivate var _contactID = ""
    fileprivate var _contactName = ""
    fileprivate var _id = ""
    
    var id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var contactID: String {
        get {
            return _contactID
        }
        set {
            _contactID = newValue
        }
    }
    
    var contactName: String {
        get {
            return _contactName
        }
        set {
            _contactName = newValue
        }
    }
}

class E2EKey: Codable {
    var privateKey: String
    
    init(privateKey: String) {
        self.privateKey = privateKey
    }
}

struct E2EPublicKey: Codable {
    var id: UUID?
    var publicKey: String
}

class E2EPublicKeys {
    
    var e2ePublicKeyVM = [E2EPublicKeyViewModel]()
    
    struct E2EPublicKeyViewModel: Hashable {
        let identifier = NSUUID()
        var id: UUID?
        var publicKey: String?
        
        init(publicKey: E2EPublicKey) {
            self.id = publicKey.id
            self.publicKey = publicKey.publicKey
        }
        
        
        static func == (lhs: E2EPublicKeyViewModel, rhs:  E2EPublicKeyViewModel) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        func requestPublicKeyObject() -> E2EPublicKeyRequest {
            let pk = self.publicKey ?? ""
            return E2EPublicKeyRequest(publicKey: pk)
        }
    }
}
struct E2EPublicKeyRequest: Codable {
    var publicKey: String
}
