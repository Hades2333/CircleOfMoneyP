//
//  DetailLookAtCellView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class DetailLookAtCellView: UIView {

    //MARK: - Variables
    var minusAction: (() -> Void)?
    var plusAction: (() -> Void)?

    //MARK: - GUI Variables
    lazy private var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "greenGreatTint")
        return view
    }()

    lazy var viewForAccountImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy var accountImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var accountName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "mainBackgroundColor")
        label.textAlignment = .left
        return label
    }()

    lazy var accountAmountOfMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "mainBackgroundColor")
        label.textAlignment = .right
        return label
    }()

    lazy private var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusButton"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(self.minusPressed),
                         for: .touchUpInside)
        return button
    }()

    lazy private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusButton"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(self.plusPressed),
                         for: .touchUpInside)
        return button
    }()

    lazy private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20.0
        return stack
    }()

    lazy private var horizontalImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10.0
        return stack
    }()

    lazy private var horizontalButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 30.0
        return stack
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
        self.addSubview(self.modalView)
        self.addSubview(self.verticalStack)

        self.verticalStack.addArrangedSubviews([self.horizontalImagesStack,
                                                self.horizontalButtonsStack])
        
        self.horizontalImagesStack.addArrangedSubviews([self.viewForAccountImage,
                                                        self.accountName,
                                                        self.accountAmountOfMoney])

        self.viewForAccountImage.addSubview(self.accountImage)

        self.horizontalButtonsStack.addArrangedSubviews([self.minusButton,
                                                         self.plusButton])
        makeConstraints()
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.modalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.verticalStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(20)
        }

        self.horizontalImagesStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        self.viewForAccountImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(self.viewForAccountImage.snp.height)
        }

        self.accountImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }

        self.accountAmountOfMoney.snp.makeConstraints { (make) in
            make.width.equalTo(self.accountName.snp.width)
        }

        self.minusButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.minusButton.snp.height)
        }

        self.plusButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.plusButton.snp.height)
        }
    }

    //MARK: - Methods
    @objc func minusPressed() {
        self.minusAction?()
    }

    @objc func plusPressed() {
        self.plusAction?()
    }
}
