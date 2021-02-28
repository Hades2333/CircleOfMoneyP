//
//  DetailLookAtCellView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class DetailLookAtCellView: UIView {

    //MARK: - Variables
    var plusAction: (() -> Void)?
    var minusAction: (() -> Void)?

    //MARK: - GUI Variables
    lazy private var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "greenLittleTint")
        return view
    }()

    lazy private var viewForAccountImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy private var accountImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy private var accountName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "mainBackgroundColor")
        return label
    }()

    lazy private var accountAmountOfMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "mainBackgroundColor")
        return label
    }()

    lazy private var minusButton: UIButton = {
        let button = UIButton()
        return button
    }()

    lazy private var plusButton: UIButton = {
        let button = UIButton()
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
        stack.alignment = .fill
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
        self.addSubviews([self.horizontalImagesStack,
                          self.horizontalButtonsStack])
        self.horizontalImagesStack.addSubviews([self.viewForAccountImage,
                                                self.accountName,
                                                self.accountAmountOfMoney])
        self.viewForAccountImage.addSubview(self.accountImage)
        self.horizontalButtonsStack.addSubviews([self.minusButton,
                                                 self.plusButton])
        makeConstraints()
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.modalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(170)
        }

        self.verticalStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(20)
        }

        self.viewForAccountImage.snp.makeConstraints { (make) in
            make.height.equalTo(self.viewForAccountImage.snp.width)
        }
    }
}
