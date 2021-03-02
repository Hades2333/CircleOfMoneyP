//
//  SignUpView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

class SignUpView: UIView {
    
    //MARK: - Variables
    var backTransition: (() -> Void)?
    var signUpTransition: (() -> Void)?

    //MARK: - GUI Variables
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        self.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(self.backButtonPressed),
                         for: .touchUpInside)
        return button
    }()

    private lazy var mainLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "signUpImage")
        return view
    }()

    lazy var emailTextField: TextFieldWithLine = {
        let view = TextFieldWithLine()
        view.textInput.placeholder = "Enter email"
        return view
    }()

    lazy var passwordTextField: TextFieldWithLine = {
        let view = TextFieldWithLine()
        view.textInput.placeholder = "Enter password"
        return view
    }()

    lazy var confirmPasswordTextField: TextFieldWithLine = {
        let view = TextFieldWithLine()
        view.textInput.placeholder = "Confirm password"
        return view
    }()

    private lazy var buttonBranch: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "littleBranch")
        return view
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Register",
                                          comment: ""),
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Varela", size: 17.0)
        button.backgroundColor = UIColor(named: "greenGreatTint")
        button.titleLabel?.textColor = UIColor(named: "")
        button.addTarget(self,
                         action: #selector(self.signUpButtonPressed),
                         for: .touchUpInside)
        return button
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        self.backgroundColor = UIColor(named: "mainBackgroundColor")
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubviews([self.backButton, self.mainLogo,
                                     self.emailTextField, self.passwordTextField,
                                     self.confirmPasswordTextField, self.buttonBranch,
                                     self.signUpButton])
        makeConstraints()
        self.signUpButton.layer.cornerRadius = 25
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.contentView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
            make.height.equalToSuperview().priority(750)
        }

        self.backButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(64)
        }

        self.mainLogo.snp.makeConstraints { (make) in
            make.top.equalTo(self.backButton.snp.bottom)
            make.left.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(self.mainLogo.snp.width)
        }

        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainLogo.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(85)
            make.height.equalTo(self.emailTextField.snp.width).multipliedBy(22.0 / 205.0)
        }

        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(85)
            make.height.equalTo(self.passwordTextField.snp.width).multipliedBy(22.0 / 205.0)
        }

        self.confirmPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(85)
            make.height.equalTo(self.confirmPasswordTextField.snp.width).multipliedBy(22.0 / 205.0)
        }

        self.signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordTextField.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(87.5)
            make.height.equalTo(self.confirmPasswordTextField.snp.width).multipliedBy(1.0 / 4.0)
        }

        self.buttonBranch.snp.makeConstraints { (make) in
            make.width.equalTo(84)
            make.height.equalTo(40)
            make.bottom.equalTo(self.signUpButton.snp.top)
            make.left.equalTo(self.signUpButton.snp.left).multipliedBy(1.0 / 3.0)
        }

    }

    //MARK: - Methods
    @objc private func backButtonPressed() {
        self.backTransition?()
    }

    @objc private func signUpButtonPressed() {
        self.signUpTransition?()
    }
}
