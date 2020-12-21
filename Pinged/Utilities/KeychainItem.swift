//
//  KeychainItem.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

struct KeychainItem {
    // MARK: Types
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError
    }
    
    // MARK: Properties
    
    let service: String
    
    private(set) var account: String
    
    let accessGroup: String?
    
    // MARK: Intialization
    
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: Keychain access
    
    func readItem() throws -> String {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    func saveItem(_ password: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        
        do {
            // Check for an existing item in the keychain.
            try _ = readItem()
            
            // Update the existing item with the new password.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
            
            let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError }
        } catch KeychainError.noPassword {
            /*
             No password was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError }
        }
    }
    
    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError }
    }
    
    // MARK: Convenience
    
    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
    
    
    static func saveUserObject(object: String) {
        do {
            try KeychainItem(service: Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_OBJECT_KEY).saveItem(object)
        } catch {
            print("Unable to save data to keychain.")
        }
    }

    static func saveE2EPrivateKey(object: String) {
        do {
            try KeychainItem(service: Constants.KEYCHAIN_SERVICE_ID, account: Constants.E2E_PRIVATE_KEY).saveItem(object)
        } catch {
            print("Unable to save data to keychain.")
        }
    }
    
    static var email: String {
        get {
            do {
                let email = try KeychainItem(service: Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_EMAIL_KEY).readItem()
                return email
            } catch {
                return ""
            }
        }
    }

    static var password: String {
        get {
            do {
                let password = try KeychainItem(service: Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_PASSWORD_KEY).readItem()
                return password
            } catch {
                return ""
            }
        }
    }
    static var userObject: String {
        do {
            let userID = try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_OBJECT_KEY).readItem()
            return userID
        } catch {
            return ""
        }
    }

    static var e2ePrivateKey: String {
        do {
            let e2e = try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.E2E_PRIVATE_KEY).readItem()
            return e2e
        } catch {
            return ""
        }
    }
 
    static func deleteE2EPrivateKey() {
        do {
            try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.E2E_PRIVATE_KEY).deleteItem()
        } catch {
            print("Unable to delete Auth from keychain")
        }
    }
    
    static func deleteKeyChainUserData() {
        do {
            try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_OBJECT_KEY).deleteItem()
            try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_EMAIL_KEY).deleteItem()
            try KeychainItem(service:  Constants.KEYCHAIN_SERVICE_ID, account: Constants.USER_PASSWORD_KEY).deleteItem()
        } catch {
            print("Unable to delete userIdentifier from keychain")
        }
    }
}
