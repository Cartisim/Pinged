//
//  VerificationEmailViewModel.swift
//  Cartisim
//
//  Created by Cole M on 6/10/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class VerificationEmails {
    
    var verificationEmailViewModel = [VerificationEmailViewModel]()
    
    struct VerificationEmailViewModel: Hashable {
        var id: UUID?
        var email: String
        
        init(email: VerificationEmail) {
            self.email = email.email
        }
        
        static func == (lhs: VerificationEmailViewModel, rhs: VerificationEmailViewModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        
        func requestVerificationEmailObject() -> VerificationEmailRequest {
            return VerificationEmailRequest(email: self.email)
        }
    }
}
