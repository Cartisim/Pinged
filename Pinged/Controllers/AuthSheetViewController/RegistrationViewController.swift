//
//  RegistrationViewController.swift
//  Pinged
//
//  Created by Cole M on 12/19/20.
//

import Cocoa

class RegistrationViewController: NSViewController {
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = RegisterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let regView = self.view as? RegisterView
        regView?.dismissButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(dismissSelf)))
    }
    
    @objc fileprivate func gestures() {
        let registrationView = self.view as! RegisterView
        registrationView.registerButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(registerUser)))
    }
    
    @objc fileprivate func confirmSheet() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.configuredCustomButtonAlert(title: "Confirm Email", text: "Check your email to confirm your account before selecting I have Confirmed", firstButtonTitle: "I have Confirmed", secondButtonTitle: "Resend Confirmation", switchRun: true)
            let run = alert.runModal()
            switch run {
            case .alertFirstButtonReturn:
                NotificationCenter.default.post(name: .registered, object: nil)
                self.dismiss(self)
            case .alertSecondButtonReturn:
                let verificationEmail = VerificationEmails.VerificationEmailViewModel(email: VerificationEmail(email: KeychainItem.email))
                NetworkUtility.shared.resendConfirmationEmail(email: verificationEmail) { [weak self] (res) in
                    guard let strongSelf = self else {return}
                    switch res {
                    case .success:
                        print("success")
                        DispatchQueue.main.async {
                            strongSelf.dismiss(strongSelf)
                        }
                    case .failure:
                        print("failure")
                    }
                }
            default:
                break
            }
        }
    }

    @objc func registerUser() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let registrationView = self.view as! RegisterView
        NSProgressIndicator().show(indicator: registrationView.progressIndicator)
        let registerCredentials = Registers.RegisterViewModel(user: Register(fullName: registrationView.nameTextField.stringValue, email: registrationView.emailTextField.stringValue, password: registrationView.passwordTextField.stringValue, confirmPassword: registrationView.confirmPasswordTextField.stringValue))
        NetworkUtility.shared.register(register: registerCredentials) { [weak self] (res) in
            guard let _ = self else {return}
            switch res {
            case .success:
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .confirmEmail,  object: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    NSAlert().configuredAlert(title: "ERROR", text: "There was an error registering: \(error)")
                }
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            NSProgressIndicator().hide(indicator: registrationView.progressIndicator)
            registrationView.nameTextField.stringValue = ""
            registrationView.emailTextField.stringValue = ""
            registrationView.passwordTextField.stringValue = ""
            registrationView.confirmPasswordTextField.stringValue = ""
        }
    }

    
    @objc fileprivate func dismissSelf() {
        self.dismiss(self)
    }
    
}
