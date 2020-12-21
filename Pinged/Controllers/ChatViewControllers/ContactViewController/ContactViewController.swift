//
//  ContactViewController.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ContactViewController: NSViewController, NSCollectionViewDelegate {
    
    var dataSource: NSCollectionViewDiffableDataSource<ContactSections, AnyHashable>!
    let contacts = Contacts()
    let chatSessions = ChatSessions()
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ContactView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchUserChatSessions), name: .refreshFetchUserChatSessions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchChatContacts), name: .refreshFetchChatContactsl, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createNewChatSession), name: .refreshPostSenderKey, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeData), name: .removeContacts, object: nil)
        fetchChatContacts()
        fetchUserChatSessions()
        let contactView = self.view as! ContactView
        contactView.collectionView.delegate = self
        contactView.collectionView.isSelectable = true
        configureHierarchy()
        configureDataSource()
    }
    
    @objc func createNewChatSession() {
        do {
            let key = Crypto.shared.userInfoKey( Constants.KEYCHAIN_ENCRYPTION_KEY)
            let decryptPrivateKey = try Crypto.shared.decryptStringToCodableObject(E2EKey.self, from: KeychainItem.e2ePrivateKey, usingKey: key)
            let privateKeyStringConsumtion = try Crypto.shared.importPrivateKey(decryptPrivateKey.privateKey)
            postSenderKey(privateKey: privateKeyStringConsumtion)
        } catch {
            print(error)
        }
    }
    
    @objc func removeData() {
        DispatchQueue.main.async {
            self.contacts.contactViewModel.removeAll()
            var snapshot = NSDiffableDataSourceSnapshot<ContactSections, AnyHashable>()
            snapshot.deleteAllItems()
            self.dataSource.apply(snapshot)
        }
    }
}
