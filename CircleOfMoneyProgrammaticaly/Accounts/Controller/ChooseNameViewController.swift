//
//  ChooseNameViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class ChooseNameViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var modalView: ChooseNameView = {
        let view = ChooseNameView()
        self.modalView.moneySelector.delegate = self
        self.modalView.moneySelector.dataSource = self
        view.backToTheAccounts = { [weak self] in
            self?.okPressed()
        }
        return view
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()
    var selectedImage = UIImage()
    var selectedColor = UIColor()
    var selectedCurrency: String = "Dollars"

    //MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(modalView)

        self.modalView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(150)
            make.left.right.equalToSuperview().inset(35)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.removeGestureRecognizer(tapGesture)
    }

    //MARK: - Methods
    @objc private func tapped() {
        let p = self.presentingViewController
        self.dismiss(animated: false) {
            p?.dismiss(animated: false, completion: nil)
        }
    }

    private func okPressed() {
        do {
            try validateChooseFields(self.modalView.nameTextField,
                                     self.modalView.moneyTextField,
                                     self.modalView.moneySelector)

            myAccounts.append(Accounts(image: Image(withImage: selectedImage),
                                       nameOfAccount: self.modalView.nameTextField.text!,
                                       amountOfMoney: (Double(self.modalView.moneyTextField.text!) ?? 0).rounded(toPlaces: 2),
                                       currency: Currency(rawValue: selectedCurrency)!))

            NotificationCenter.default.post(name: .accountsDataWasUpdated,
                                            object: nil,
                                            userInfo: nil)
            
            tapped()
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
    }

    func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(tapped))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension ChooseNameViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {

        if let touchView = touch.view {
            if touchView.isDescendant(of: self.modalView){
                return false
            }
        }
        return true
    }
}

//MARK: - UIPickerViewDelegate
extension ChooseNameViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return currency[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrency = currency[row]
    }
}

//MARK: - UIPickerViewDataSource
extension ChooseNameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
}


