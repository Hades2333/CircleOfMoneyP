//
//  ViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 19.02.21.
//

import UIKit
import SnapKit

class FirstScreenViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var firstScreenView: FirstScreenView = {
        let view = FirstScreenView()
        view.signUpTransition = { [weak self] in
            self?.transitionToSignUpViewController()
        }
        view.logInTransition = { [weak self] in
            self?.transitionToLogInViewController()
        }
        return view
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(firstScreenView)
        self.firstScreenView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()  
        }
    }

    //MARK: - Navigation
    private func transitionToSignUpViewController() {
        let next = SignUpViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }

    private func transitionToLogInViewController() {
        let next = LogInViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }

}

