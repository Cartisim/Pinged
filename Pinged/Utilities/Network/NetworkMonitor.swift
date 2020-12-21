//
//  NetworkMonitor.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation
import Network

class NetworkMonitor: NSObject {
    
    static let shared = NetworkMonitor()
    let monitorPath = NWPathMonitor()
    
    func networkMonitor() {
        monitorPath.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else {return}
            if path.status == .satisfied {
                print("We're connected")
                NotificationCenter.default.post(name: .connected, object: nil)
                strongSelf.setUserDataState()
            } else if path.status == .unsatisfied {
                print("We're not connected")
                NotificationCenter.default.post(name: .notConnected, object: nil)
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitorPath.start(queue: queue)
    }
    
    func networkStatus() -> Bool {
        if monitorPath.currentPath.status == .satisfied {
            return true
        } else {
            return false
        }
    }

    fileprivate func setUserDataState() {
        let key = Crypto.shared.userInfoKey( Constants.KEYCHAIN_ENCRYPTION_KEY)
        do {
            let decrypUserObject = try Crypto.shared.decryptStringToCodableObject(Auth.self, from: KeychainItem.userObject, usingKey: key)
            guard let userID = decrypUserObject.userID else {return}
         
            guard let username = decrypUserObject.username else {return}
            guard let access = decrypUserObject.accessToken else {return}
            guard let refresh = decrypUserObject.refreshToken else {return}
            UserData.shared.accessToken = access
            UserData.shared.refreshToken = refresh
            UserData.shared.userID = userID
            UserData.shared.username = username
        } catch let error {
            print(error, "There was an error decrypting auth status items")
        }
    }

}

