//
//  CalculatorView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class CalculatorView: UIView {

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

        makeConstraints()
        self.modalView.layer.cornerRadius = 20
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
    }
//    @IBOutlet weak var fromImage: UIImageView!
//    @IBOutlet weak var operationImage: UIImageView!
//    @IBOutlet weak var toButton: UIButton!
//    @IBOutlet weak var textField: COtextFieldWithLine! {
//        didSet {
//            self.textField.textInput.clearButtonMode = .whileEditing
//            self.textField.textInput.font = UIFont(name: "Varela", size: 20.0)
//            self.textField.textInput.textColor = UIColor(named: "greenLittleTint")
//        }
//    }
//    @IBOutlet var calculatorButtons: [UIButton]!
}
