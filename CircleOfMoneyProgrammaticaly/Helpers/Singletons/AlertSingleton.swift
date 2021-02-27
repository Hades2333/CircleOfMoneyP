//
//  AlertSingleton.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

class LNAlertHelper {

    // MARK: - Singleton
    static let shared = LNAlertHelper()

    // MARK: - Initialization
    private init() { }

    // MARK: - Methods
    func show(for controller: UIViewController,
              title: String = "",
              message: String = "",
              firstButtonTitle: String? = nil,
              secondButtonTitle: String,
              firstButtonAction: (() -> Void)? = nil,
              secondButtonAction: (() -> Void)?) {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if let leftTitle = firstButtonTitle {
            alert.addAction(UIAlertAction(title: leftTitle,
                                          style: .cancel,
                                          handler: { (_) in firstButtonAction?() }))
        }
        alert.addAction(UIAlertAction(title: secondButtonTitle,
                                      style: .cancel,
                                      handler: { (_) in
                                        secondButtonAction?()
                                      }))
        controller.present(alert, animated: true)
    }
}

extension LNAlertHelper: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
