//
//  CalculatorView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit



class CalculatorView: UIView {

    //MARK: - Variables
    var myDelegate: CalculatorViewControllerDelegate?

    //MARK: - GUI Variables
    lazy private var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy private var topVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .red
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10.0
        return stack
    }()

    lazy private var bottomVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .black
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10.0
        return stack
    }()

    lazy var fromImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .cyan
        return image
    }()

    lazy var operationImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        return image
    }()

    lazy private var emptyImages: [UIImageView] = {
        var images = [UIImageView]()
        for element in 0...2 {
            let image = UIImageView()
            image.backgroundColor = .brown
            images.append(image)
        }
        return images
    }()

    lazy var textField: TextFieldWithLine = {
        let textField = TextFieldWithLine()
        textField.textInput.clearButtonMode = .whileEditing
        textField.textInput.font = UIFont(name: "Varela", size: 20.0)
        textField.textInput.textColor = UIColor(named: "greenLittleTint")
        return textField
    }()

    lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for element in 0...11 {
            let button = UIButton()
            button.tag = element
            button.setTitleColor(UIColor(named: "greenLittleTint"),
                                 for: .normal)
            button.backgroundColor = UIColor(named: "mainBackgroundColor")
            button.addTarget(self,
                             action: #selector(self.buttonPressed(_:)),
                             for: .touchUpInside)
            buttons.append(button)
        }
        for index in 0...9 {
            buttons[index].setTitle("\(index)", for: .normal)
        }
        buttons[10].setTitle(".", for: .normal)
        buttons[11].setTitle("Ok", for: .normal)
        return buttons
    }()

    lazy private var horizontalTopStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .green
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20.0
        return stack
    }()

    lazy private var commonHorizontalStack: [UIStackView] = {
        var stacks = [UIStackView]()
        for _ in 0...3 {
            let stack = UIStackView()
            stack.backgroundColor = .white
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillEqually
            stack.spacing = 30.0
            stacks.append(stack)
        }
        return stacks
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

        self.modalView.addSubviews([self.topVerticalStack,
                                    self.bottomVerticalStack])

        self.topVerticalStack.addArrangedSubviews([self.horizontalTopStack,
                                                   self.textField])

        self.horizontalTopStack.addArrangedSubviews([self.fromImage,
                                                     self.operationImage,
                                                     self.emptyImages[0],
                                                     self.emptyImages[1],
                                                     self.emptyImages[2]])
        for index in 0...3 {
            self.bottomVerticalStack.addArrangedSubview(commonHorizontalStack[index])
        }

        for index in 0...2 {
            self.commonHorizontalStack[0].addArrangedSubview(buttons[index])
        }

        for index in 3...5 {
            self.commonHorizontalStack[1].addArrangedSubview(buttons[index])
        }

        for index in 6...8 {
            self.commonHorizontalStack[2].addArrangedSubview(buttons[index])
        }

        for index in 9...11 {
            self.commonHorizontalStack[3].addArrangedSubview(buttons[index])
        }

        makeConstraints()
        configureElements()
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.modalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.topVerticalStack.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(20)
            make.height.lessThanOrEqualTo(150)
        }

        self.bottomVerticalStack.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(self.topVerticalStack.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        self.fromImage.snp.makeConstraints { (make) in
            make.width.equalTo(self.fromImage.snp.height)
        }

        for index in 0...11 {
            self.buttons[index].snp.makeConstraints { (make) in
                make.width.equalTo(self.buttons[index].snp.height)
            }
        }
    }

    //MARK: - Methods
    private func configureElements() {
        self.modalView.layer.cornerRadius = 20

        self.buttons.forEach {
            $0.backgroundColor = UIColor(named: "mainBackgroundColor")
            $0.tintColor = UIColor(named: "greenLittleTint")
            $0.titleLabel?.font = UIFont(name: "Varela", size: 20.0)
            $0.layer.cornerRadius = self.buttons[0].bounds.height / 2
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .zero
            $0.layer.shadowRadius = 5
        }
    }

    @objc func buttonPressed(_ sender: UIButton) {
        myDelegate?.action(with: sender)
    }
}
