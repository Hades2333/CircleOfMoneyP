//
//  FirstScreenUIView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 26.02.21.
//

import UIKit

class FirstScreenView: UIView {
    
    //MARK: - Variables
    var signUpTransition: (() -> Void)?
    var logInTransition: (() -> Void)?

    //MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        self.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bigLogo")
        return view
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Welcome message",
                                       comment: "")
        label.font = UIFont(name: "VAG World", size: 30.0)
        label.textColor = UIColor(named: "greenGreatTint")
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        return label
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = NSLocalizedString("Second greeting",
                                       comment: "")
        label.font = UIFont(name: "Varela", size: 14.0)
        label.textColor = UIColor(named: "greenLittleTint")
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        return label
    }()

    private lazy var signUpBranch: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mainBranch")
        view.contentMode = .scaleAspectFit
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

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Enter",
                                          comment: ""),
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Varela", size: 14.0)
        button.setTitleColor(UIColor(named: "greenGreatTint"), for: .normal)
        button.addTarget(self,
                         action: #selector(self.logInButtonPressed),
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
        self.contentView.addSubviews([self.logoImage, self.welcomeLabel,
                                     self.textLabel, self.signUpBranch,
                                     self.signUpButton, self.choiceLabel,
                                     self.logInButton])
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

        self.logoImage.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(50)
            make.height.equalTo(self.logoImage.snp.width).multipliedBy(169.0 / 243.0)
        }

        self.welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImage.snp.bottom)
            make.left.right.equalToSuperview().inset(50)
        }

        self.textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.welcomeLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(90)
            make.height.equalTo(self.textLabel.snp.width).multipliedBy(47.0 / 84.0)
        }

        self.signUpBranch.snp.makeConstraints { (make) in
            make.top.equalTo(self.textLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(105)
            make.height.equalTo(self.logoImage.snp.width).multipliedBy(1.0 / 3.0)
        }

        self.signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpBranch.snp.bottom).offset(-10)
            make.left.right.equalToSuperview().inset(87.5)
            make.height.equalTo(self.signUpButton.snp.width).multipliedBy(1.0 / 4.0)
        }

        self.choiceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpButton.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(70)
            make.height.equalTo(self.logoImage.snp.width).multipliedBy(16.0 / 147.0)
        }

        self.logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.choiceLabel.snp.bottom).offset(-10)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(self.logoImage.snp.width).multipliedBy(33.0 / 175.0)
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
