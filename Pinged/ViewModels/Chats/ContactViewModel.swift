//
//  ContactViewModel.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

class Contacts {
    
    var contactViewModel = [ContactViewModel]()
    
    struct ContactViewModel: Hashable {
        let identifier = NSUUID()
        var id: UUID?
        var fullName: String
        var publicKey: String?
        var createdAt: String?
        var updatedAt: String?
        
        init(contact: Contact) {
            self.id = contact.id
            self.fullName = contact.fullName
            self.publicKey = contact.publicKey
            self.createdAt = contact.createdAt
            self.updatedAt = contact.updatedAt
        }
        
        static func == (lhs: ContactViewModel, rhs:  ContactViewModel) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let filter = filterText
            return !id!.uuidString.contains(filter)
        }
        
        func search(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return fullName.lowercased().contains(lowercasedFilter)
        }
        func requestContactObject() -> ContactRequest {
            let pk = self.publicKey ?? ""
            return ContactRequest(contactID: self.id, fullName: self.fullName, publicKey: pk)
        }
    }
    func filterContacts(with filter: String?) -> [ContactViewModel] {
        return contactViewModel.filter ({ $0.contains(filter)})
    }
}
