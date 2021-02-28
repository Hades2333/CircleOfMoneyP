//
//  AccountsView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class AccountsView: UIView {

    //MARK: - Variables
    var signUpTransition: (() -> Void)?
    var logInTransition: (() -> Void)?

    //MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
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

    private lazy var choiceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Question about account",
                                       comment: "")
        label.font = UIFont(name: "Varela", size: 14.0)
        label.textColor = UIColor(named: "greenLittleTint")
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        return label
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //        private func initView() {
    //            self.backgroundColor = UIColor(named: "mainBackgroundColor")
    //            self.addSubview(self.scrollView)
    //            self.scrollView.addSubview(self.contentView)
    //            self.contentView.addSubviews([self.logoImage, self.welcomeLabel,
    //                                         self.textLabel, self.signUpBranch,
    //                                         self.signUpButton, self.choiceLabel,
    //                                         self.logInButton])
    //            makeConstraints()
    //            self.signUpButton.layer.cornerRadius = 25
    //        }

    //MARK: - Constraints
    func makeConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }


    }

    //MARK: - Methods
    @objc private func signUpButtonPressed() {
        self.signUpTransition?()
    }

    @objc private func logInButtonPressed() {
        self.logInTransition?()
    }

}



