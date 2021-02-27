//
//  ErrorHandler.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

enum ValidationError: Error {
    case emptyField(String)
    case invalidPassword
    case invalidEmail
    case passwordsDoNotMatch
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyField(let field):
            return NSLocalizedString("\(field) field is empty.",
                                     comment: "")
        case .invalidPassword:
            return NSLocalizedString("""
                                     The password was entered incorrectly.
                                     Passwort must contain:
                                     Latin letters, numbers, special characters
                                     and be at least eight characters long.
                                     """,
                                     comment: "")
        case .invalidEmail:
            return NSLocalizedString("The email was entered incorrectly.",
                                     comment: "")
        case .passwordsDoNotMatch:
            return NSLocalizedString("""
                                     Passwords do not match.
                                     Please enter the same passwords.
                                     """,
                                     comment: "")
        }
    }
}

