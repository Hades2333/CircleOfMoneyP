//
//  HomeDetailViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

protocol HomeDetailViewControllerDelegate: AnyObject {
    func updateAccountTarget(_ accountId: Int)
}

class HomeDetailViewController: UIViewController {
    
    //MARK: - GUI Variables
    lazy var modalView: HomeDetailView = {
        let view = HomeDetailView()
        view.chooseAccount = { [weak self] in
            self?.transitionToHomeChooseAccount()
        }
        return view
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()
    var tempLabel: String = ""
    private var id: Int?
    private var accountTargetId: Int?
    private var categoryTargetId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalView.homeDelegate = self
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureLayers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.removeGestureRecognizer(tapGesture)
    }

    //MARK: - Navigation
    @objc private func tapped() {
        dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Methods
    func configureLayers() {
        self.modalView.horizontalButtonsTopStack.layer.cornerRadius = 20
        self.modalView.horizontalButtonsTopStack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.modalView.fromButton.layer.cornerRadius = 20
        self.modalView.rightView.layer.cornerRadius = 20
        self.modalView.fromButton.layer.maskedCorners = [.layerMinXMinYCorner]
        self.modalView.rightView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }

    func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(tapped))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }

    func updateLabelAndId(with text: String, id: Int) {
        self.tempLabel = "Category: \(text)"
        self.categoryTargetId = id
    }

    func checkForValidation() throws {
        guard accountTargetId != nil else { throw NumberError.account }
        guard let text = modalView.textField.textInput.text else { throw NumberError.emptyField }
        guard !text.isEmpty else { throw NumberError.emptyField }
        guard Double(text) != nil else { throw NumberError.invalidNumber }
    }

    func convert(from account: Accounts,
                 to category: Categories,
                 amount: Double) throws {

        let categoryCurrency: String = "\(category.currency)"
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/b8cf407191ff9a2a81cde6e9/latest/\(categoryCurrency)") else {
            throw NumberError.account
        }

        var convertedValue: Double = 0.0

        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in

            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else { return }
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)

                convertedValue = amount * (results.conversion_rates["\(account.currency)"]!)

                guard let id = accountTargetId else {
                    fatalError("couldnt find id for account")
                }
                myAccounts[id].amountOfMoney -= convertedValue

            } catch {
                print("Ошибка: \(error)")
            }
        }.resume()
    }

    func convertAndTakeAway() {
        guard let id = accountTargetId else {
            fatalError("couldnt find id for account")
        }
        let accountCurrency = myAccounts[id].currency
        guard let categoryTargetId = self.categoryTargetId else {
            fatalError("couldnt find id for category")
        }
        let categoryCurrency = myCategories[categoryTargetId].currency

        if accountCurrency == categoryCurrency {
            myAccounts[id].amountOfMoney -= Double(modalView.textField.textInput.text!)!.rounded(toPlaces: 2)
        } else {
            do {
                try convert(from: myAccounts[id],
                            to: myCategories[categoryTargetId],
                            amount: Double(modalView.textField.textInput.text!)!)
            } catch {
                print(error)
            }
        }
    }

    func plusAmountToCategory(_ amount: Double) {
        guard let categoryTargetId = self.categoryTargetId else {
            fatalError("couldnt find id for category")
        }
        myCategories[categoryTargetId].amountOfMoney += amount
    }

    //MARK: - Navigation
    private func transitionToHomeChooseAccount() {
        let next = HomeChooseAccountViewCotroller()

        next.modalTransitionStyle = .coverVertical
        next.modalPresentationStyle = .overCurrentContext
        next.homeDelegate = self
        present(next, animated: false, completion: nil)
    }

    private func calculatorButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0...9:
            self.modalView.textField.textInput.text?.append("\(sender.tag)")
        case 10:
            self.modalView.textField.textInput.text?.append(".")
        case 11:
            do {
                try checkForValidation()

                convertAndTakeAway()

                let money = Double(self.modalView.textField.textInput.text!)!
                plusAmountToCategory(money)

                myOperations.append(Operations(category: myCategories[categoryTargetId ?? 0],
                                               account: myAccounts[accountTargetId ?? 0],
                                               amountOfMoney: money,
                                               currency: myCategories[categoryTargetId ?? 0].currency,
                                               date: Date()))

                NotificationCenter.default.post(name: .accountsAndCategoriesWasUpdated,
                                                object: nil,
                                                userInfo: nil)
                NotificationCenter.default.post(name: .operationsUpdate,
                                                object: nil,
                                                userInfo: nil)
                dismiss(animated: false)
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

extension HomeDetailViewController: UIGestureRecognizerDelegate {
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

extension HomeDetailViewController: CalculatorViewControllerDelegate {
    func action(with sender: UIButton) {
        self.calculatorButtonPressed(sender)
    }
}

extension HomeDetailViewController: HomeDetailViewControllerDelegate {
    func updateAccountTarget(_ accountId: Int) {
        self.accountTargetId = accountId
        self.modalView.fromButton.setImage(myAccounts[accountId].image.getImage(), for: .normal)
        self.modalView.fromButton.setTitle("", for: .normal)
        self.modalView.onCategory.text = myAccounts[accountId].nameOfAccount
    }
}

