//
//  Keys.swift
//  Cartisim
//
//  Created by Cole M on 11/15/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Keys: Codable {
    var keychainEncryptionKey: String?
    var refreshNetworkKey: String?
    var userEmailKey: String?
    var userPasswordKey: String?
    var userIDKey: String?
    var usernameKey: String?
    var orderIDKey: String?
    var siwaAuthKey: String?
    var tokensKey: String?
    var subscriptionStatusKey: String?
    var isAdminKey: String?
    var isContractorKey: String?
    var keychainServiceID: String?
    var weeklyProductKey: String?
    var monthlyProductKey: String?
    var yearlyProductKey: String?
    var inAppSharedSecret: String?
    var e2eSalt: String?
    var e2ePrivateKey: String?
    
    init(keychainEncryptionKey: String? = "", refreshNetworkKey: String? = "", userEmailKey: String? = "", userPasswordKey: String? = "", userIDKey: String? = "", usernameKey: String? = "", tokensKey: String? = "", keychainServiceID: String? = "", inAppSharedSecret: String? = "", e2eSalt: String? = "", e2ePrivateKey: String? = "") {
        self.keychainServiceID = keychainServiceID
        self.refreshNetworkKey = refreshNetworkKey
        self.userEmailKey = userEmailKey
        self.userPasswordKey = userPasswordKey
        self.userIDKey = userIDKey
        self.usernameKey = usernameKey
        self.tokensKey = tokensKey
        self.keychainServiceID = keychainServiceID
        self.inAppSharedSecret = inAppSharedSecret
        self.e2eSalt = e2eSalt
        self.e2ePrivateKey = e2ePrivateKey
    }
}

struct KeyData {
    static var shared = KeyData()
    
    fileprivate var _keychainEncryptionKey: String = ""
    fileprivate var _refreshNetworkKey: String = ""
    fileprivate var _userEmailKey: String = ""
    fileprivate var _userPasswordKey: String = ""
    fileprivate var _userIDKey: String = ""
    fileprivate var _usernameKey: String = ""
    fileprivate var _tokensKey: String = ""
    fileprivate var _keychainServiceID: String = ""
    fileprivate var _inAppSharedSecret: String = ""
    fileprivate var _e2eSalt: String = ""
    fileprivate var _e2ePrivateKey: String = ""
    
    var keychainEncryptionKey: String {
        get {
            return _keychainEncryptionKey
        }
        set {
            _keychainEncryptionKey = newValue
        }
    }
    var refreshNetworkKey: String {
        get {
            return _refreshNetworkKey
        }
        set {
            _refreshNetworkKey = newValue
        }
    }
    var userEmailKey: String {
        get {
            return _userEmailKey
        }
        set {
            _userEmailKey = newValue
        }
    }
    var userPasswordKey: String {
        get {
            return _userPasswordKey
        }
        set {
            _userPasswordKey = newValue
        }
    }
    var userIDKey: String {
        get {
            return _userIDKey
        }
        set {
            _userIDKey = newValue
        }
    }
    var usernameKey: String {
        get {
            return _usernameKey
        }
        set {
            _usernameKey = newValue
        }
    }

    var tokensKey: String {
        get {
            return _tokensKey
        }
        set {
            _tokensKey = newValue
        }
    }
  
    var keychainServiceID: String {
        get {
            return _keychainServiceID
        }
        set {
            _keychainServiceID = newValue
        }
    }
    
    var e2eSalt: String {
        get {
            return _e2eSalt
        }
        set {
            _e2eSalt = newValue
        }
    }
    
    var e2ePrivateKey: String {
        get {
            return _e2ePrivateKey
        }
        set {
            _e2ePrivateKey = newValue
        }
    }

}
