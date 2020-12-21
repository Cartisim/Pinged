//
//  ChatroomViewController+CollectionView.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension ChatroomViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    }
    
    func configureHierarchy() {
        let chatroomView = self.view as! ChatroomView
        chatroomView.collectionView.collectionViewLayout = createLayout()
        chatroomView.collectionView.register(ChatViewItem.self, forItemWithIdentifier: Constants.CHAT_IDENTIFIER)
    }
    
    func setCollectionViewItem(chatViewItem: ChatViewItem? = nil, chat: Chatrooms.ChatroomViewModel? = nil) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let chatView = self.view as! ChatroomView
        if chatViewItem != nil {
            let unwrappedImage = NSImage(imageLiteralResourceName: "pingedLogo")
            let resizedImage = NSImageView().resizeImage(image: unwrappedImage, maxSize: NSSize(width: 30, height: 30))
            chatViewItem?.chatItem?.avatar.image = resizedImage.roundCorners(withRadius: 10)
            
            if chat?.createdAt != nil {
                let df = DateFormatter()
                let createdString = chat?.createdAt ?? ""
                let updatedString = chat?.updatedAt ?? ""
                let created = df.date(from: createdString) ?? Date()
                let updated = df.date(from: updatedString) ?? Date()
                
                if updated >= created {
                    chatViewItem?.chatItem?.dateLabel.stringValue = df.getFormattedDate(currentFormat: DateFormats.eighth.rawValue, newFormat: DateFormats.first.rawValue, dateString: createdString)
                } else {
                    chatViewItem?.chatItem?.dateLabel.stringValue = df.getFormattedDate(currentFormat: DateFormats.eighth.rawValue, newFormat: DateFormats.first.rawValue, dateString: updatedString)
                }
            }
            let decryptedName = Crypto.shared.decryptText(text: chat?.fullName ?? "", symmetricKey: ChatSessionData.shared.chatSymmetricKey)
            chatViewItem?.chatItem?.name.stringValue = decryptedName
            let decryptedMessage = Crypto.shared.decryptText(text: chat?.message ?? "", symmetricKey: ChatSessionData.shared.chatSymmetricKey)
            chatViewItem?.chatItem?.message.attributedStringValue = attributedMessage(message: decryptedMessage)
            chatViewItem?.chatItem?.optionsButton.isHidden = true
            if UserData.shared.userID == chat?.contactID {
                chatViewItem?.chatItem?.optionsButton.isHidden = false
                chatViewItem?.chatItem?.optionsButton.target = self
                chatViewItem?.chatItem?.optionsButton.action = #selector(optionsButtonClicked(_:))
            }
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            NSProgressIndicator().hide(indicator: chatView.progressIndicator)
        }
    }
    
    func attributedMessage(message: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: message)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.firstLineHeadIndent = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func configureDataSource() {
        let chatroomView = self.view as! ChatroomView
        dataSource = NSCollectionViewDiffableDataSource<ChatroomSections, AnyHashable> (collectionView: chatroomView.collectionView) { [weak self] (collectionView: NSCollectionView, indexPath: IndexPath, identifier: Any) -> NSCollectionViewItem? in
            guard let strongSelf = self else {return nil}
            let section = ChatroomSections(rawValue: indexPath.section)!
            switch section {
            case .chatroom:
                let chatViewItem = collectionView.makeItem(withIdentifier: Constants.CHAT_IDENTIFIER, for: indexPath) as! ChatViewItem
                if let chat = identifier as? Chatrooms.ChatroomViewModel {
                    strongSelf.setCollectionViewItem(chatViewItem: chatViewItem, chat: chat)
                    chatViewItem.chatItem?.optionsButton.tag = indexPath.item
                } else {
                    fatalError("Cannot create other item")
                }
                return chatViewItem
            }
        }
    }
    
    
    //ToDo: Fix section layout
    fileprivate func createLayout() -> NSCollectionViewLayout {
        let layout = NSCollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionIndex {
            case 0:
                return Sections.shared.chatSection()
            default:
                return Sections.shared.defaultSection()
            }
        }
        return layout
    }
    
    @objc func optionsButtonClicked(_ sender: NSButton) {
        let item = sender.tag
        let indexPath = IndexPath(item: item, section: 0)
            let object = dataSource.itemIdentifier(for: indexPath)
            if let object = object as? Chatrooms.ChatroomViewModel {
                guard let id =  object.id?.uuidString else {return}
                ChatroomData.shared.messageID = id
                let popover = NSPopover()
                let vc = ChatroomItemPopoverViewController(object: object, snapshot: dataSource.snapshot(), datasource: dataSource)
                popover.contentViewController = vc
                popover.behavior = .transient
                popover.show(relativeTo: sender.self.bounds, of: sender.self, preferredEdge: .maxX)
            }
    }
}
