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
