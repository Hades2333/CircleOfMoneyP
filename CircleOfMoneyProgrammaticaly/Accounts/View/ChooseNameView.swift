//
//  ChooseNameView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class ChooseNameView: UIView {

    //MARK: - GUI Variables
    //    self.firstLayerModalView.layer.cornerRadius = 20.0
    lazy private var modalView: UIView = {
        let view = UIView()
        return view
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy private var moneyLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    //    self.nameTextField.layer.cornerRadius = self.nameTextField.frame.height / 2
    lazy private var nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

//    self.moneyTextField.layer.cornerRadius = self.moneyTextField.frame.height / 2
    lazy private var moneyTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    lazy var moneySelector: UIPickerView = {
        let selector = UIPickerView()
        return selector
    }()

    //    self.okButton.layer.cornerRadius = self.okButton.frame.height / 2
    //            self.okButton.setTitle("OK", for: .normal)
    lazy private var okButton: UIButton = {
        let button = UIButton()
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
                                    self.moneyTextField, self.moneySelector,
                                    self.okButton])
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
            make.top.height.equalTo(20)
        }

        self.moneyTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.height.equalTo(20)
        }

        self.moneyLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(self.moneyTextField.snp.bottom).offset(20)
            make.height.equalTo(20)
        }

        self.moneySelector.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.moneyTextField.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(70)
        }

        self.okButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(self.moneySelector.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}
