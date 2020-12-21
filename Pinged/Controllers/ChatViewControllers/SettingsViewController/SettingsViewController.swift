//
//  SettingsViewController.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa


class SettingsViewController: NSViewController {
    
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(authenticated), name: .authenticate, object: nil)
       authenticated()
        gestures()
    }
    
    @objc func authenticated() {
        DispatchQueue.main.async {
            let settingsView = self.view as? SettingsView
            if UserData.shared.accessToken.isEmpty {
                settingsView?.authButton.isHidden = false
                settingsView?.logoutButton.isHidden = true
            } else {
                settingsView?.authButton.isHidden = true
                settingsView?.logoutButton.isHidden = false
            }
        }
    }
    
    fileprivate func gestures() {
        let settingsView = self.view as? SettingsView
        settingsView?.authButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(showAuthSheet)))
        settingsView?.logoutButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(logout)))
    }
    
    @objc fileprivate func showAuthSheet() {
        presentAsSheet(LoginViewController())
    }
    
    @objc func logout() {
        KeychainItem.deleteKeyChainUserData()
        UserData.shared.accessToken = ""
        UserData.shared.refreshToken = ""
        UserData.shared.userID = ""
        authenticated()
        NotificationCenter.default.post(name: .removeContacts, object: nil)
        NotificationCenter.default.post(name: .removeChats, object: nil)
        NotificationCenter.default.post(name: .removeChatroom, object: nil)
    }
}
