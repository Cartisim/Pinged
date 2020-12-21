//
//  Constants.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

let BASE_URL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
let AUTH_URL = "\(BASE_URL)auth/"


struct Constants {
    //    static let shared = Constants()
    static let TCP_HOST = Bundle.main.object(forInfoDictionaryKey: "TCP_HOST") as! String
    //Identifiers
    static let CHAT_IDENTIFIER = NSUserInterfaceItemIdentifier(rawValue: "chatID")
    static let CONTACT_IDENTIFIER = NSUserInterfaceItemIdentifier(rawValue: "contactID")
    static let SECTION_HEADER_ELEMENT_OF_KIND = "section-header-element-kind"
    static let SECTION_HEADER_ELEMENT_OF_KIND_IDENTIFIER = NSUserInterfaceItemIdentifier(rawValue: "section-header-element-kind-identifier")
    
    //Path Items
    static let USER = "user"
    
    //URLS
    static let FETCH_KEYS_URL = "\(BASE_URL)fetchKeys/"
    static let REGISTER_URL = "\(AUTH_URL)register"
    static let LOGIN_URL = "\(AUTH_URL)login"
    static let EMAIL_VERIFICATION_URL = "\(AUTH_URL)email-verification"
    static let RESET_PASSWORD__URL = "\(AUTH_URL)reset-password"
    static let VERIFY_URL = "\(AUTH_URL)verify"
    static let RECOVER_URL = "\(AUTH_URL)recover"
    static let REFRESH_TOKEN_URL = "\(AUTH_URL)accessToken"
    static let CURRENT_USER_URL = "\(AUTH_URL)currentUser"
    static let DELETE_CURRENT_USER_URL = "\(AUTH_URL)deleteCurrentUser/\(UserData.shared.userID)"
    static let CHAT_SESSIONS_URL = "\(BASE_URL)chatSessions"
    static let CHAT_MESSAGES_URL = "\(BASE_URL)fetchChatSessionMessages/"
    static let DELETE_CHAT_MESSAGE_URL = "\(BASE_URL)deleteChatMessage/"
    static let FETCH_USER_CHAT_SESSION = "\(BASE_URL)fetchUserChatSession/"
    static let DELETE_CHAT_SESSION_URL = "\(BASE_URL)deleteChatSession/"
    static let CHAT_CONTACTS_URL = "\(BASE_URL)chatContacts"
    static let POST_SENDER_URL = "\(BASE_URL)postSender"
    static let ADD_KEY_TO_USER_URL = "\(BASE_URL)addKeyToUser/"
    
    //Keys
    static let KEYCHAIN_ENCRYPTION_KEY = "keychainEncryptionKey"
    static let REFRESH_NETWORK_KEY = "refreshNetworkKey"
    static let USER_EMAIL_KEY = "userEmailKey"
    static let USER_PASSWORD_KEY = "userPasswordKey"
    static let USER_ID_KEY = "userIDKey"
    static let USER_OBJECT_KEY = "userObjectKey"
    static let USER_NAME_KEY = "usernameKey"
    static let TOKENS_KEY = "tokensKey"
    static let KEYCHAIN_SERVICE_ID = "io.app.Pinged"
    static let E2E_SALT = "Our Salt"
    static let E2E_PRIVATE_KEY = "e2ePrivateKey"
    
    //Defaults
    static let AUTH_ERROR = "authError"
    //Colors
    static let DARK_CHARCOAL_COLOR = NSColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1).cgColor
    static let OFF_WHITE_COLOR = NSColor(calibratedRed: 221, green: 221, blue: 221, alpha: 1)
    
    //Cache
    static let CACHE = NSCache<NSString, NSImage>()
    
    //Parsing Keys
    static let CACHE_KEY_COMPONENT = "Date="
    static let DATE_COMPONENT = "&X-Amz-Expires="
    static let EXPIRED_COMPONENT = "&X-Amz-SignedHeaders=host"
    
    //Image literal names
    static let APP_ICON = "AppIcon"
    static let CARTISIM_LOGO = "pingedLogo"
    
    //ToolBar Identifiers
    static let SEARCH_BAR = "SearchBar"
    static let SETTINGS_BUTTON = "SettingsButton"
    static let CONTACTS_BUTTON = "ContactsButton"
    static let CHAT_WINDOW_TOOLBAR = "ChatWindowToolbar"
    
}

//Attibutes
let color = NSColor.lightGray
let font = NSFont.systemFont(ofSize: 15)
let attrs = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]


