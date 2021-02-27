//
//  textFieldWithLine.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit

class TextFieldWithLine: UIView {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var colorStick: UIView!

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldWithLine", owner: self,
                                 options: nil)

        addSubview(backgroundView)
        backgroundView.frame = self.bounds
        backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        self.textInput.backgroundColor = UIColor(named: "mainBackgroundColor")
        self.textInput.tintColor = UIColor(named: "greenLittleTint")
        self.textInput.textColor = UIColor(named: "greenLittleTint")
        self.textInput.font = UIFont(name: "Varela", size: 16.0)
        self.textInput.clearButtonMode = .whileEditing

        self.backgroundView.backgroundColor = UIColor(named: "mainBackgroundColor")

        self.colorStick.backgroundColor = UIColor(named: "greenLittleTint")

    }
}
