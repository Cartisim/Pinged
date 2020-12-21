//
//  ChatsViewController+CollectionView.swift
//  Cartisim
//
//  Created by Cole M on 12/7/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension ChatSessionsViewController {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
            let object = dataSource.itemIdentifier(for: collectionView.selectionIndexPaths.first!)
            if let object = object as? ChatSessions.ChatSessionsViewModel {
                NotificationCenter.default.post(name: .clearChatroomData, object: nil)
                guard let id = object.id?.uuidString else {return}
                let pk = object.publicKey
                ChatSessionData.shared.chatSessionID = id
                Crypto.shared.derivedKeyLogic(publicKey: pk)
            }
    }
    
    func configureHierarchy() {
        let chatsView = self.view as! ChatsView
        chatsView.collectionView.collectionViewLayout = createLayout()
        chatsView.collectionView.register(ContactViewItem.self, forItemWithIdentifier: Constants.CONTACT_IDENTIFIER)
        chatsView.collectionView.register(CenterHeader.self, forSupplementaryViewOfKind: Constants.SECTION_HEADER_ELEMENT_OF_KIND, withIdentifier: Constants.SECTION_HEADER_ELEMENT_OF_KIND_IDENTIFIER)
    }
    
    func setCollectionViewItem(chatsViewItem: ContactViewItem? = nil, chatSession: ChatSessions.ChatSessionsViewModel? = nil) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let chatsView = self.view as! ChatsView
        if chatsViewItem != nil {
            chatsViewItem?.contactItem?.name.stringValue = chatSession?.fullName ?? "no name"
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            NSProgressIndicator().hide(indicator: chatsView.progressIndicator)
        }
    }
    
    func configureDataSource() {
        let chatsView = self.view as! ChatsView
        dataSource = NSCollectionViewDiffableDataSource<ChatSessionsSections, AnyHashable> (collectionView: chatsView.collectionView) { [weak self] (collectionView: NSCollectionView, indexPath: IndexPath, identifier: Any) -> NSCollectionViewItem? in
            guard let strongSelf = self else {return nil}
            let section = ChatSessionsSections(rawValue: indexPath.section)!
            switch section {
            case .chats:
                let chatsViewItem = collectionView.makeItem(withIdentifier: Constants.CONTACT_IDENTIFIER, for: indexPath) as! ContactViewItem
                if let chatSession = identifier as? ChatSessions.ChatSessionsViewModel {
                    strongSelf.setCollectionViewItem(chatsViewItem: chatsViewItem, chatSession: chatSession)
                } else {
                    fatalError("Cannot create other item")
                }
                return chatsViewItem
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
                        case .chats:
                            supplementaryView.label.stringValue = HeaderFooterTitles.chats.rawValue
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
