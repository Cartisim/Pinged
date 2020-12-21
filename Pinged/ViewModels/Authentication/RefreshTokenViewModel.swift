//
//  RefreshTokenViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/10/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class RefreshTokens {
    
    var refreshTokenViewModel = [RefreshTokenViewModel]()
    
    struct RefreshTokenViewModel: Hashable {
        var id: UUID?
        var refreshToken: String
        
        init(refreshToken: RefreshToken) {
            self.refreshToken = refreshToken.refreshToken
        }
        
        static func == (lhs: RefreshTokenViewModel, rhs: RefreshTokenViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        
        func requestRefreshTokenObject() -> RefreshTokenRequest {
            return RefreshTokenRequest(refreshToken: self.refreshToken)
        }
    }
}
