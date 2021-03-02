//
//  HomeChooseNameViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class HomeChooseNameViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var modalView: HomeChooseNameView = {
        let view = HomeChooseNameView()
        view.okAction = { [weak self] in
            self?.okButtonPressed()
        }
        return view
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()

    var mySelectedImage = UIImage()
    var selectedColor = UIColor()
    var selectedCurrency: String = "Dollars"

    //    //MARK: - Lifcycle
    override func viewDidLoad() {

        self.modalView.moneySelector.delegate = self
        self.modalView.moneySelector.dataSource = self
        
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
    func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(tapped))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }

    //MARK: - Navigation
    @objc private func tapped() {
        done()
    }

    func done() {
        dismissAllmodals(animated: false)
    }

    //MARK: - Methods
    private func okButtonPressed() {
        do {
            try validateChooseFields(self.modalView.nameTextField,
                                     nil,
                                     self.modalView.moneySelector)

            myCategories.append(Categories(image: Image(withImage: mySelectedImage),
                                           nameOfAccount: modalView.nameTextField.text!,
                                           amountOfMoney: 0.0,
                                           color: Color(uiColor: selectedColor),
                                           currency: Currency(rawValue: selectedCurrency)!))

            NotificationCenter.default.post(name: .accountsAndCategoriesWasUpdated,
                                            object: nil,
                                            userInfo: nil)
            done()
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
}

//MARK: - UIGestureRecognizerDelegate
extension HomeChooseNameViewController: UIGestureRecognizerDelegate {

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

//MARK: - UIPickerViewDelegate
extension HomeChooseNameViewController: UIPickerViewDelegate {
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
extension HomeChooseNameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
}
