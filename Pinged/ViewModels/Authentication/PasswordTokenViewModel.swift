//
//  PasswordTokenViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class PasswordTokens {
    
    var passwordTokenViewModel = [PasswordTokenViewModel]()
    
    struct PasswordTokenViewModel: Hashable {
        var id: UUID?
        var accessToken: String
        var refreshToken: String
        var user: User?
        
        init(passwordToken: PasswordToken) {
            self.id = passwordToken.id
            self.accessToken = passwordToken.accessToken
            self.refreshToken = passwordToken.refreshToken
            self.user = passwordToken.user
        }
        static func == (lhs: PasswordTokenViewModel, rhs: PasswordTokenViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}


class SIWATokens {
    
    var siwaTokenViewModel = [SWIATokenViewModel]()
    
    struct SWIATokenViewModel: Hashable {
        var id: UUID?
        var accessToken: String
        var refreshToken: String
        
        init(siwaToken: SIWAToken) {
            self.id = siwaToken.id
            self.accessToken = siwaToken.accessToken
            self.refreshToken = siwaToken.refreshToken
        }
        static func == (lhs: SWIATokenViewModel, rhs: SWIATokenViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
