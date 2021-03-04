//
//  UIViewController+Ex.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

extension UIViewController {

    //MARK: - Tap Gesture
    func keyboardHideWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    //MARK: - Validation
    func isEmailValid(_ email : String) -> Bool {

        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }

    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

    func validateFields(_ email: TextFieldWithLine,
                        _ password: TextFieldWithLine,
                        _ confirmPassword: TextFieldWithLine? = nil) throws {

        guard !email.textInput.text!.isEmpty else
        {throw ValidationError.emptyField("Email")}

        guard isEmailValid(email.textInput.text!) else {
            throw ValidationError.invalidEmail
        }

        guard !password.textInput.text!.isEmpty else
        {throw ValidationError.emptyField("Password")}

        guard isPasswordValid(password.textInput.text!) else {
            throw ValidationError.invalidPassword
        }

        if let secondPassword = confirmPassword {
            guard password.textInput.text! ==
                    secondPassword.textInput.text! else {
                throw ValidationError.passwordsDoNotMatch
            }
        }
    }

   //MARK: - Validation for name, amount and currency fields:
    func validateChooseFields(_ name: UITextField,
                              _ amount: UITextField?,
                              _ currency: UIPickerView) throws {

        guard !name.text!.isEmpty else { throw InputError.emptyName }

        if amount != nil {
            guard !amount!.text!.isEmpty else { throw InputError.emptyAmount }
            guard !amount!.text!.isEmpty else { throw InputError.emptyAmount }
        }
    }

    //MARK: - Validation numbers:
    func numberIsValid(_ field: TextFieldWithLine, _ sign: String) throws -> Double {
        guard let text = field.textInput.text, !text.isEmpty else { throw NumberError.emptyField }
        guard let number = Double("\(sign)\(text)") else { throw NumberError.invalidNumber }
        return number
    }

//    //MARK: - Header constructor
//    func headerConstructor(_ view: UIView,
//                         _ height: CGFloat,
//                         _ title: String) -> UIView {
//        let widthSize = view.bounds.size.width
//
//        let header = UIView(frame: CGRect(x: 0, y: 0,
//                                          width: widthSize,
//                                          height: height + 10))
//
//        header.backgroundColor = UIColor(named: "mainBackgroundColor")
//        let headerLabel: UILabel = UILabel(frame: header.bounds)
//        headerLabel.text = "      " + "\(title):"
//        headerLabel.textAlignment = .left
//        headerLabel.font = UIFont(name: "Varela", size: height)
//        headerLabel.textColor = UIColor(named: "greenLittleTint")
//        header.addSubview(headerLabel)
//        return header
//    }
}

//MARK: - Dismiss All extension
extension UIViewController {
    func dismissAllmodals(animated: Bool, completion: (() -> Void)? = nil) {
        if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
            if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
                presentedViewController.view.addSubview(snapshotView)
                presentedViewController.modalTransitionStyle = .coverVertical
            }
            if !isBeingDismissed {
                rootViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
}

//extension UIViewController {
//    func countAccountsMoney() throws -> String {
//
//        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/b8cf407191ff9a2a81cde6e9/latest/USD") else {
//            throw NumberError.account
//        }
//
//        var allMoney: [Double] = []
//
//        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
//
//            if error != nil {
//                print(error!)
//                return
//            }
//            guard let safeData = data else { return }
//            do {
//                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
//
//
//                for account in myAccounts {
//                    if account.currency.rawValue == "USD" {
//                        allMoney.append(account.amountOfMoney)
//                    } else {
//                        let converted = account.amountOfMoney * (results.conversion_rates["\(account.currency.rawValue)"] ?? 1.0)
//                        allMoney.append(converted)
//                    }
//                }
//
//            } catch {
//                print("Ошибка: \(error)")
//            }
//        }.resume()
//        return String("\(allMoney.reduce(0, +))")
//    }
//}
