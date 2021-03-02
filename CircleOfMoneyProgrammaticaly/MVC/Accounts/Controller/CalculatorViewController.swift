//
//  CalculatorViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

protocol CalculatorViewControllerDelegate {
    func action(with sender: UIButton)
}

class CalculatorViewController: UIViewController {
    
    //MARK: - GUI Variables
    private lazy var modalView: CalculatorView = {
        let view = CalculatorView()
        view.myDelegate = self
        return view
    }()
    
    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()
    private var tempFromImage: UIImage?
    private var tempOperationImage: UIImage?
    private var id: Int?
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupGestures()
        view.addSubview(self.modalView)
        
        self.modalView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(118)
        }
        self.modalView.layer.cornerRadius = 25.0

        updateGUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.removeGestureRecognizer(tapGesture)
    }
    
    //MARK: - Methods
    func transferGUI(_ from: UIImage,
                     _ operation: UIImage,
                     _ id: Int) {
        self.tempFromImage = from
        self.tempOperationImage = operation
        self.id = id
    }
    
    func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(tapped))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped() {
        NotificationCenter.default.post(Notification.init(name: .accountsDataWasUpdated))
        let p = self.presentingViewController
        self.dismiss(animated: false) {
            p?.dismiss(animated: false, completion: nil)
        }
    }

    func updateGUI() {
        self.modalView.fromImage.image = tempFromImage
        self.modalView.operationImage.image = tempOperationImage
    }

    func okPressed(with number: Double) {
        guard let existingId = self.id else { fatalError("id not found") }
        myAccounts[existingId].amountOfMoney += number.rounded(toPlaces: 2)
        tapped()
    }

    func calculatorButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0...9:
            self.modalView.textField.textInput.text?.append("\(sender.tag)")
            self.modalView.textField.reloadInputViews()
        case 10:
            self.modalView.textField.textInput.text?.append(".")
        case 11:
            do {
                let sign = self.modalView.operationImage.image == UIImage(named: "onlyPlus") ? "+" : "-"
                try okPressed(with: numberIsValid(self.modalView.textField, sign))
            } catch {
                LNAlertHelper.shared.show(
                    for: self,
                    title: "Error",
                    message: error.localizedDescription,
                    secondButtonTitle: "Ok",
                    secondButtonAction: {
                        print("Alert was closed")
                    })
            }
        default:
            return
        }
    }
}

//MARK: - CalculatorViewControllerDelegate
extension CalculatorViewController: CalculatorViewControllerDelegate {
    func action(with sender: UIButton) {
        calculatorButtonPressed(sender)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension CalculatorViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        
        if let touchView = touch.view {
            if touchView.isDescendant(of: modalView){
                return false
            }
        }
        return true
    }
}


