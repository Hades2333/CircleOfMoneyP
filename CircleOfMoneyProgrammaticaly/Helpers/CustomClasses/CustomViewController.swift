//
//  CustomUIViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

class CustomViewController: UIViewController {

    @objc func keyboardWillShow(_ scroll: UIScrollView,
                          _ notification: Notification) {

        guard let userInfo = (notification as Notification).userInfo else { return }
        guard let keyboardNSValue: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keybordFrame = keyboardNSValue.cgRectValue

        scroll.contentInset.bottom = keybordFrame.size.height + 50
    }

    @objc func keyboardWillHide(_ scroll: UIScrollView) {
        scroll.contentInset.bottom = .zero
    }
}
