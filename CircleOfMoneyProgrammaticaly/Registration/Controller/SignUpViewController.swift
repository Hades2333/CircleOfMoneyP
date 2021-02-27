//
//  SignUpViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit
import SnapKit
import Firebase

class SignUpViewController: CustomViewController {
    //MARK: - GUI Variables
    private lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.backTransition = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.signUpTransition = { [weak self] in
            self?.toRegister()
        }
        return view
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.view.addSubview(signUpView)
        self.signUpView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.registerForKeyboardNotifications()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        self.unregisterFromKeyboardNotifications()
//    }
//
//    // MARK: - Methods for keyboard
//    @objc override func keyboardWillShow(_ scroll: UIScrollView,
//                                   _ notification: Notification) {
//        super.keyboardWillShow(self.signUpView.scrollView, notification)
//    }
//
//    @objc override func keyboardWillHide(_ scroll: UIScrollView) {
//        super.keyboardWillHide(self.signUpView.scrollView)
//    }
//
//    // MARK: - Observers
//    private func registerForKeyboardNotifications() {
//        self.unregisterFromKeyboardNotifications()
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillShow(_:_:)),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillHide(_:)),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//    }
//
//    private func unregisterFromKeyboardNotifications() {
//        NotificationCenter.default.removeObserver(self,
//                                                  name: UIResponder.keyboardWillShowNotification,
//                                                  object: nil)
//        NotificationCenter.default.removeObserver(self,
//                                                  name: UIResponder.keyboardWillHideNotification,
//                                                  object: nil)
//    }
    private func toRegister() {

        do {
            try validateFields(self.signUpView.emailTextField,
                               self.signUpView.passwordTextField,
                               self.signUpView.confirmPasswordTextField)

            let userEmail = signUpView.emailTextField.textInput.text!
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let userPassword = signUpView.passwordTextField.textInput.text!
                .trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().createUser(withEmail: userEmail,
                                   password: userPassword) { (result, err ) in

                if err != nil {
                    print(err?.localizedDescription as Any)
                } else {
                    print("User signs up successfully")

                    // переход на главный экран
                    //self.performSegue(withIdentifier: Constants.Segues.signUpVCToCircleBarC, sender: self)
                }
            }
        } catch {
            LNAlertHelper.shared.show(
                for: self,
                title: "Error",
                message: error.localizedDescription,
                secondButtonTitle: "Ok",
                secondButtonAction: {
                    print("Alert was closed")
                })
        }
    }

}
