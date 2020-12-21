//
//  UserData.swift
//  Cartisim
//
//  Created by Cole M on 12/18/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation


struct UserData {
    
    static var shared = UserData()
    
    fileprivate var _userID = ""
    fileprivate var _username: String = ""
    fileprivate var _userObject: Users.UserViewModel? = nil
    fileprivate var _accessToken: String = ""
    fileprivate var _refreshToken: String = ""
    
    var userID: String {
        get {
            return _userID
        }
        set {
            _userID = newValue
        }
    }
    
    var username: String {
        get {
            return _username
        }
        set {
            _username = newValue
        }
    }
    
    var userObject: Users.UserViewModel {
        get {
            return _userObject!
        }
        set {
            _userObject = newValue
        }
    }
    
    var accessToken: String {
        get {
            return _accessToken
        }
        set {
            _accessToken = newValue
        }
    }
    
    var refreshToken: String {
        get {
            return _refreshToken
        }
        set {
            _refreshToken = newValue
        }
    }
}
