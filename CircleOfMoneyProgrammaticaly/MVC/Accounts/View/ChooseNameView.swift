//
//  ChooseNameView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class ChooseNameView: UIView {

    //MARK: - Closures
    var backToTheAccounts: (() -> Void)?

    //MARK: - GUI Variables
    lazy private var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "greenLittleTint")
        label.text = "Choose Name"
        return label
    }()

    lazy private var moneyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "greenLittleTint")
        label.text = "Choose amount of money"
        return label
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        return textField
    }()

    lazy var moneyTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        return textField
    }()

    lazy var moneySelector: UIPickerView = {
        let selector = UIPickerView()
        return selector
    }()

    lazy private var okButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Ok",
                                          comment: ""),
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Varela", size: 17.0)
        button.backgroundColor = UIColor(named: "greenGreatTint")
        button.titleLabel?.textColor = UIColor(named: "mainBackgroundColor")
        button.addTarget(self,
                         action: #selector(self.okButtonPressed),
                         for: .touchUpInside)
        button.layer.cornerRadius = 25
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
        //MARK: - Сделать цвет прозрачный наполовину

        self.addSubview(self.modalView)
        self.modalView.addSubviews([self.nameLabel, self.moneyLabel,
                                    self.nameTextField, self.moneyTextField,
                                    self.moneySelector, self.okButton])
        makeConstraints()
        self.modalView.layer.cornerRadius = 20
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.modalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }

        self.nameTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.height.equalTo(30)
        }

        self.moneyLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(self.nameTextField.snp.bottom).offset(20)
            make.height.equalTo(20)
        }

        self.moneyTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.moneyLabel.snp.bottom).offset(5)
            make.height.equalTo(30)
        }

        self.moneySelector.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.moneyTextField.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(50)
        }

        self.okButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(100)
            make.top.equalTo(self.moneySelector.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    //MARK: - Methods
    @objc func okButtonPressed() {
        self.backToTheAccounts?()
    }
}
