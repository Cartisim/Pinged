//
//  ContactViewController+Network.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa
import CryptoKit

extension ContactViewController {
    
    
    @objc func fetchChatContacts() {
        NetworkUtility.shared.fetchChatContacts { [weak self] (res) in
            switch res {
            case .success(let contacts):
                guard let strongSelf = self else {return}
                print(contacts)
                strongSelf.contacts.contactViewModel.append(contentsOf: contacts.map({Contacts.ContactViewModel(contact: $0)}))
                strongSelf.createSnapshot()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func fetchUserChatSessions() {
        NetworkUtility.shared.fetchUserChatSessions { [weak self] (res) in
            switch res {
            case .success(let user):
                guard let strongSelf = self else {return}
                strongSelf.chatSessions.chatSessionsViewModel.append(contentsOf: user.chatSession.map({ ChatSessions.ChatSessionsViewModel(chatSessions: $0) }))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func postSenderKey(privateKey: Curve25519.KeyAgreement.PrivateKey) {
        let exportedPrivateKey = Crypto.shared.exportPrivateKey(privateKey)
        guard let pk = try? Crypto.shared.importPrivateKey(exportedPrivateKey) else {
            return NSAlert().configuredAlert(title: "ERROR", text: "Could not import Private Key")
        }
        
        let publicKey = pk.publicKey
        let exportedPublicKey = Crypto.shared.exportPublicKey(publicKey)
        NetworkUtility.shared.postSenderKey(chatSession: ChatSessions.ChatSessionsViewModel(chatSessions: ChatSession(contactID: ContactData.shared.contactID, fullName: ContactData.shared.contactName, publicKey: exportedPublicKey))) { [weak self] (res) in
            guard let _ = self else {return}
            switch res {
            case .success(let session):
                print(session, "Sesssion")
                guard let id = session.id?.uuidString else {return}
                ChatSessionData.shared.chatSessionID = id
                NotificationCenter.default.post(name: .fetchChatSession, object: nil)
                let pk = session.publicKey 
                Crypto.shared.derivedKeyLogic(publicKey: pk)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func createSnapshot() {
        #if DEBUG || LOCAL
        var snapshot = NSDiffableDataSourceSnapshot<ContactSections, AnyHashable>()
        #else
        let filter = self.contacts.filterContacts(with: UserData.shared.userID).sorted { $0.fullName < $1fullNamename }
        #endif
        let filter = self.contacts.contactViewModel.sorted { $0.fullName < $1.fullName }
        snapshot.appendSections([.contact])
        snapshot.appendItems(filter, toSection: .contact)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}
