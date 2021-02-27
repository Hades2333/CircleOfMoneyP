//
//  SignUpViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    //MARK: - GUI Variables
    private lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.backTransition = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.signUpTransition = { [weak self] in
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

}
