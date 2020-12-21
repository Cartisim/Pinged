//
//  ContactViewController+CollectionView.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa
import CryptoKit

extension ContactViewController {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
            let object = dataSource.itemIdentifier(for: collectionView.selectionIndexPaths.first!)
            if let object = object as? Contacts.ContactViewModel {
                let sessions = chatSessions.chatSessionsViewModel
                let id = object.id?.uuidString
                if !sessions.isEmpty {
                    sessions.forEach { (session) in
                        guard let contactID = session.contactID else {return}
                        if id != session.contactID && !contactID.isEmpty {
                            ContactData.shared.contactID = id ?? ""
                            ContactData.shared.contactName = object.fullName
                            createNewChatSession()
                        }
                    }
                } else {
                    ContactData.shared.contactID = id ?? ""
                    ContactData.shared.contactName = object.fullName
                    createNewChatSession()
                }
            }
    }
    
    func configureHierarchy() {
        let contactView = self.view as! ContactView
        contactView.collectionView.collectionViewLayout = createLayout()
        contactView.collectionView.register(ContactViewItem.self, forItemWithIdentifier: Constants.CONTACT_IDENTIFIER)
        contactView.collectionView.register(CenterHeader.self, forSupplementaryViewOfKind: Constants.SECTION_HEADER_ELEMENT_OF_KIND, withIdentifier: Constants.SECTION_HEADER_ELEMENT_OF_KIND_IDENTIFIER)
    }
    
    func setCollectionViewItem(contactViewItem: ContactViewItem? = nil, contact: Contacts.ContactViewModel? = nil) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let contactView = self.view as! ContactView
        if contactViewItem != nil {
            //TODO: set option to scramble name
            contactViewItem?.contactItem?.name.stringValue = contact?.fullName ?? ""
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            NSProgressIndicator().hide(indicator: contactView.progressIndicator)
        }
    }
    
    func configureDataSource() {
        let contactView = self.view as! ContactView
        dataSource = NSCollectionViewDiffableDataSource<ContactSections, AnyHashable> (collectionView: contactView.collectionView) { [weak self] (collectionView: NSCollectionView, indexPath: IndexPath, identifier: Any) -> NSCollectionViewItem? in
            guard let strongSelf = self else {return nil}
            let section = ContactSections(rawValue: indexPath.section)!
            switch section {
            case .contact:
                let contactViewItem = collectionView.makeItem(withIdentifier: Constants.CONTACT_IDENTIFIER, for: indexPath) as! ContactViewItem
                if let contact = identifier as? Contacts.ContactViewModel {
                    strongSelf.setCollectionViewItem(contactViewItem: contactViewItem, contact: contact)
                } else {
                    fatalError("Cannot create other item")
                }
                return contactViewItem
            }
        }
        
        dataSource.supplementaryViewProvider = {
            (collectionView: NSCollectionView, kind: String, indexPath: IndexPath) -> (NSView & NSCollectionViewElement)? in
            if let supplementaryView = collectionView.makeSupplementaryView(
                ofKind: Constants.SECTION_HEADER_ELEMENT_OF_KIND,
                withIdentifier: Constants.SECTION_HEADER_ELEMENT_OF_KIND_IDENTIFIER,
                for: indexPath) as? CenterHeader {
                if let object = self.dataSource.itemIdentifier(for: indexPath) {
                    if let section = self.dataSource.snapshot().sectionIdentifier(containingItem: object) {
                        switch section {
                        case .contact:
                            supplementaryView.label.stringValue = HeaderFooterTitles.contacts.rawValue
                            supplementaryView.label.font = .systemFont(ofSize: 18)
                        }
                    }
                }
                return supplementaryView
            } else {
                fatalError("Cannot create new supplementary")
            }
        }
        
    }
    
    fileprivate func createLayout() -> NSCollectionViewLayout {
        let layout = NSCollectionViewCompositionalLayout {
            
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionIndex {
            case 0:
                return Sections.shared.listWithSmallHeaderSection()
            default:
                return Sections.shared.defaultSection()
            }
        }
        return layout
    }
}
