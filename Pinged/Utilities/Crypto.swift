//
//  Crypto.swift
//  Cartisim
//
//  Created by Cole M on 11/14/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation
import CryptoKit

final class Crypto {

    static let shared = Crypto()
    
    func userInfoKey(_ key: String) -> SymmetricKey {
        let hash = SHA256.hash(data: key.data(using: .utf8)!)
        let hashString = hash.map { String(format: "%02hhx", $0)}.joined()
        let subString = String(hashString.prefix(32))
        let keyData = subString.data(using: .utf8)!
        return SymmetricKey(data: keyData)
    }
    
    func encryptCodableObject<T: Codable>(_ object: T, usingKey key: SymmetricKey) throws -> String {
        let encoder = JSONEncoder()
        let userData = try encoder.encode(object)
        let encryptedData = try AES.GCM.seal(userData, using: key)
        return encryptedData.combined!.base64EncodedString()
    }
    
    func decryptStringToCodableObject<T: Codable>(_ type: T.Type, from string: String, usingKey key: SymmetricKey) throws -> T {
        let data = Data(base64Encoded: string)!
        let box = try AES.GCM.SealedBox(combined: data)
        let decryptData = try AES.GCM.open(box, using: key)
        let decoder = JSONDecoder()
        let object = try decoder.decode(type, from: decryptData)
        return object
    }
    
    func generatePrivateKey() -> Curve25519.KeyAgreement.PrivateKey {
        let privateKey = Curve25519.KeyAgreement.PrivateKey()
        return privateKey
    }
    
    func importPrivateKey(_ privateKey: String) throws -> Curve25519.KeyAgreement.PrivateKey {
        let privateKeyBase64 = privateKey.removingPercentEncoding!
        let rawPrivateKey = Data(base64Encoded: privateKeyBase64)!
        return try Curve25519.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKey)
    }
    
    func exportPrivateKey(_ privateKey: Curve25519.KeyAgreement.PrivateKey) -> String {
        let rawPrivateKey = privateKey.rawRepresentation
        let privateKeyBase64 = rawPrivateKey.base64EncodedString()
        let percentEncodedPrivateKey = privateKeyBase64.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return percentEncodedPrivateKey
    }
    
    func importPublicKey(_ publicKey: String) throws -> Curve25519.KeyAgreement.PublicKey {
        let base64PublicKey = publicKey.removingPercentEncoding!
        let rawPublicKey = Data(base64Encoded: base64PublicKey)!
        let publicKey = try Curve25519.KeyAgreement.PublicKey(rawRepresentation: rawPublicKey)
        return publicKey
    }
    
    func exportPublicKey(_ publicKey: Curve25519.KeyAgreement.PublicKey) -> String {
        let rawPublicKey = publicKey.rawRepresentation
        let base64PublicKey = rawPublicKey.base64EncodedString()
        let encodedPublicKey = base64PublicKey.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return encodedPublicKey
    }
    
    func deriveSymmetricKey(privateKey: Curve25519.KeyAgreement.PrivateKey, publicKey: Curve25519.KeyAgreement.PublicKey) throws -> SymmetricKey {
        let sharedSecret = try privateKey.sharedSecretFromKeyAgreement(with: publicKey)
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: Constants.E2E_SALT.data(using: .utf8)!, sharedInfo: Data(), outputByteCount: 32)
        
        return symmetricKey
    }
    
    func encryptText(text: String, symmetricKey: SymmetricKey) throws -> String {
        let textData = text.data(using: .utf8)!
        let encrypted = try AES.GCM.seal(textData, using: symmetricKey)
        return encrypted.combined!.base64EncodedString()
    }
    
    func decryptText(text: String, symmetricKey: SymmetricKey) -> String {
        do {
            guard let data = Data(base64Encoded: text) else {
                return "Could not decode text: \(text)"
            }
            
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            guard let text = String(data: decryptedData, encoding: .utf8) else {
                return "Could not decode data: \(decryptedData)"
            }
            return text
        } catch let error {
            return "Error decrypting text: \(error.localizedDescription)"
        }
    }
    
    func derivedKeyLogic(publicKey: String) {
        do {
            let key = Crypto.shared.userInfoKey( Constants.KEYCHAIN_ENCRYPTION_KEY)
            let decryptPrivateKey = try Crypto.shared.decryptStringToCodableObject(E2EKey.self, from: KeychainItem.e2ePrivateKey, usingKey: key)
            let privateKeyStringConsumtion = try Crypto.shared.importPrivateKey(decryptPrivateKey.privateKey)
            let importedPublicKey = try Crypto.shared.importPublicKey(publicKey)
            let derivedKey = try Crypto.shared.deriveSymmetricKey(privateKey: privateKeyStringConsumtion, publicKey: importedPublicKey)
            ChatSessionData.shared.chatSymmetricKey = derivedKey
            NotificationCenter.default.post(name: .startObservingChatroom, object: nil)
        } catch {
            print(error)
        }
    }
}
