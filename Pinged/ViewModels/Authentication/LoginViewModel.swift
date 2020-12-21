//
//  LoginViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Logins {
    
    var loginViewModel = [LoginViewModel]()
    
    struct LoginViewModel: Hashable {
        var id: UUID?
        var email: String
        var password: String
        
        init(user: Login) {
            self.email = user.email
            self.password = user.password
        }
        
        static func == (lhs: LoginViewModel, rhs: LoginViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        
        func requestLoginObject() -> LoginRequest {
            return LoginRequest(email: self.email.lowercased(), password: self.password)
        }
    }
}
