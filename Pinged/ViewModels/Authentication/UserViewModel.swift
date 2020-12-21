//
//  UserViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Users {
    
    var usersViewModel = [UserViewModel]()
    var userInputViewModel = [UserInputViewModel]()
    
    class UserViewModel: Hashable {
        var identifier = NSUUID()
        var id: UUID?
        var fullName: String
        var email: String
        var isAdmin: Bool
        var updatedAt: String
        var createdAt: String

        init(user: User) {
            self.id = user.id
            self.fullName = user.fullName
            self.email = user.email
            self.isAdmin = user.isAdmin
            self.updatedAt = user.updatedAt
            self.createdAt = user.createdAt
        }
        
        static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct UserInputViewModel: Hashable {
        var fullName: String
        var email: String
        
        init(user: UserInput) {
            self.fullName = user.fullName
            self.email = user.email
        }
        
        func requestUserObject() -> UserRequest {
            return UserRequest(fullName: self.fullName, email: self.email)
        }
    }
}
