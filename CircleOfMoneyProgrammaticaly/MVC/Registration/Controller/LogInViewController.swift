//
//  LogInViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit
import SnapKit
import FirebaseAuth

class LogInViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var logInView: LogInView = {
        let view = LogInView()
        view.backTransition = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.logInTransition = { [weak self] in
            self?.toLogIn()
        }
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(logInView)
        self.logInView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.unregisterFromKeyboardNotifications()
    }

    // MARK: - Methods for keyboard
    @objc private func keyboardWillShow(_ notification: Notification) {

        guard let userInfo = (notification as Notification).userInfo else { return }
        guard let keyboardNSValue: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keybordFrame = keyboardNSValue.cgRectValue

        self.logInView.scrollView.contentInset.bottom = keybordFrame.size.height + 50
    }

    @objc private func keyboardWillHide() {
        self.logInView.scrollView.contentInset.bottom = .zero
    }

    // MARK: - Observers
    private func registerForKeyboardNotifications() {
        self.unregisterFromKeyboardNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    //MARK: - Methods
    private func toLogIn() {

        //MARK: - TO DO - delete in production
        let next = TabBar()
        self.navigationController?.pushViewController(next, animated: true)

//        do {
//            try validateFields(self.logInView.emailTextField,
//                               self.logInView.passwordTextField)
//
//            let userEmail = self.logInView.emailTextField.textInput.text!
//                .trimmingCharacters(in: .whitespacesAndNewlines)
//            let userPassword = self.logInView.passwordTextField.textInput.text!
//                .trimmingCharacters(in: .whitespacesAndNewlines)
//
//            Auth.auth().signIn(withEmail: userEmail,
//                               password: userPassword) { (result, error) in
//                if error != nil {
//                    print(error?.localizedDescription as Any)
//                } else {
//                    print("User log in successfully")
//                }
//
//                let next = TabBar()

//                self.navigationController?.pushViewController(next, animated: true)
//            }
//        } catch {
//            LNAlertHelper.shared.show(
//                for: self,
//                title: "Error",
//                message: error.localizedDescription,
//                secondButtonTitle: "Ok",
//                secondButtonAction: {
//                    print("Alert was closed")
//                })
//        }
    }
}
