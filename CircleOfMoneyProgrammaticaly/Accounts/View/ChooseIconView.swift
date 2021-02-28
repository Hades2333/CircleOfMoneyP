//
//  ChooseIconView.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class ChooseIconView: UIView {

    //MARK: - GUI Variables
    private lazy var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy var chooseIconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Varela", size: 17.0)
        label.textColor = UIColor(named: "greenLittleTint")
        label.text = "Choose Icon"
        return label
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
        self.modalView.addSubview(self.chooseIconLabel)
        makeConstraints()
        self.modalView.layer.cornerRadius = 20
    }

    //MARK: - Constraints
    func makeConstraints() {
        self.modalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.chooseIconLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.height.equalTo(20)
        }
    }
}
