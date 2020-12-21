//
//  AuthSheetViewController.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa
import CryptoKit

class LoginViewController: NSViewController {

    let passwordTokens = PasswordTokens()
    let users = Users()
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NotificationCenter.default.addObserver(self, selector: #selector(loginCurrentUser), name: .registered, object: nil)
        let loginView = self.view as? LoginView
        loginView?.dismissButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(dismissClicked)))
        loginView?.loginButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(loginCurrentUser)))
        loginView?.regButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(registerClicked)))
        
    }
    
    @objc func loginCurrentUser() {
        let key = Crypto.shared.userInfoKey( Constants.KEYCHAIN_ENCRYPTION_KEY)
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
            let loginView = self.view as! LoginView
        let loginCredentials = Logins.LoginViewModel(user: Login(email: loginView.emailTextField.stringValue, password: loginView.passwordTextField.stringValue))
        print(loginCredentials)
        NetworkUtility.shared.login(login: loginCredentials) { [weak self] (res) in
            print(res)
            guard let strongSelf = self else { return }
            switch res {
            case .success(let payload):
                print("payload", payload)
                guard let user = payload.user else {return}
                strongSelf.passwordTokens.passwordTokenViewModel.append(PasswordTokens.PasswordTokenViewModel(passwordToken: payload))
                strongSelf.users.usersViewModel.append(Users.UserViewModel(user: user))
                let userObjectString = try! Crypto.shared.encryptCodableObject(Auth(accessToken: payload.accessToken, refreshToken: payload.refreshToken, userID: user.id?.uuidString, username: user.fullName), usingKey: key)
                KeychainItem.saveUserObject(object: userObjectString)
                UserData.shared.accessToken = payload.accessToken
                UserData.shared.refreshToken = payload.refreshToken
                UserData.shared.userID = user.id!.uuidString
                UserData.shared.username = user.fullName
            case .failure(let error):
                print(error, "Login Error")
                DispatchQueue.main.async {
                    NSAlert().configuredAlert(title: "Error", text: "There was an unexpected error: \(error.localizedDescription)")
                }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else {return}
            if KeychainItem.e2ePrivateKey.isEmpty {
                let privateKey = Crypto.shared.generatePrivateKey()
                let privateKeyString = Crypto.shared.exportPrivateKey(privateKey)
                let e2ePrivateKeyString = try! Crypto.shared.encryptCodableObject(E2EKey(privateKey: privateKeyString), usingKey: key)
                KeychainItem.saveE2EPrivateKey(object: e2ePrivateKeyString)
                strongSelf.addKeyToUser(privateKey: privateKey)
            }
            NotificationCenter.default.post(name: .authenticate, object: nil)
            NotificationCenter.default.post(name: .fetchChatSession, object: nil)
            strongSelf.dismissClicked()
        }
    }
    
    fileprivate func addKeyToUser(privateKey: Curve25519.KeyAgreement.PrivateKey) {
        let exportedPrivateKey = Crypto.shared.exportPrivateKey(privateKey)
        guard let pk = try? Crypto.shared.importPrivateKey(exportedPrivateKey) else {
            return NSAlert().configuredAlert(title: "ERROR", text: "Could not import Private Key")
        }
        let publicKey = pk.publicKey
        let exportedPublicKey = Crypto.shared.exportPublicKey(publicKey)
        NetworkUtility.shared.addKeyToUser(key: E2EPublicKeys.E2EPublicKeyViewModel(publicKey: E2EPublicKey(publicKey: exportedPublicKey))) { [weak self] (res) in
            guard let _ = self else {return}
            switch res {
            case .success:
                print("Successfully add key to User")
            case .failure(let error):
                print("There was an error adding key to user", error.description)
            }
        }
    }
    
    @objc fileprivate func registerClicked() {
        let vc = RegistrationViewController()
        present(vc, animator: SlideAnimation())
    }
    
    @objc fileprivate func dismissClicked() {
        self.dismiss(self)
    }
}

