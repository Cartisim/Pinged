//
//  RegisterViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Registers {
    
    var registerViewModel = [RegisterViewModel]()
    
    struct RegisterViewModel: Hashable {
        var id: UUID?
        var fullName: String
        var email: String
        var password: String
        var confirmPassword: String
        
        init(user: Register) {
            self.fullName = user.fullName
            self.email = user.email
            self.password = user.password
            self.confirmPassword = user.confirmPassword
        }
        
        static func == (lhs: RegisterViewModel, rhs: RegisterViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        
        func requestRegisterObject() -> RegisterRequest {
            return RegisterRequest(fullName: self.fullName, email: self.email.lowercased(), password: self.password, confirmPassword: self.password)
        }
    }
}
