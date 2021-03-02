//
//  HomeDetailViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

protocol ChooseAccountDetailViewControllerDelegate: AnyObject {
    func updateAccountTarget(_ accountId: Int)
}

class HomeDetailViewController: UIViewController {
    
    //MARK: - GUI Variables
    lazy var modalView: HomeDetailView = {
        let view = HomeDetailView()
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

//        self.modalView.moneySelector.delegate = self
//        self.modalView.moneySelector.dataSource = self
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

        self.modalView.buttons.forEach {
            $0.layer.cornerRadius = self.modalView.buttons[0].bounds.height / 2
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .zero
            $0.layer.shadowRadius = 5
        }
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

    //    func checkForValidation() throws {
    //        guard accountTargetId != nil else { throw NumberError.account }
    //        guard let text = textField.textInput.text else { throw NumberError.emptyField }
    //        guard !text.isEmpty else { throw NumberError.emptyField }
    //        guard Double(text) != nil else { throw NumberError.invalidNumber }
    //    }

    func homeOkPressed() {
        // выходим обратно
        performSegue(withIdentifier: "fromDetailBackToHome", sender: nil)
    }

    //MARK: - TO Do error handling
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
                print("вот та самая ошибка \(error)")
            }
        }.resume()
    }

    //    func takeAwayFromAccount() {
    //        guard let id = accountTargetId else {
    //            fatalError("couldnt find id for account")
    //        }
    //
    //        // валюта счёта
    //        let accountCurrency = myAccounts[id].currency
    //        // валюта категории
    //        guard let categoryTargetId = self.categoryTargetId else {
    //            fatalError("couldnt find id for category")
    //        }
    //        let categoryCurrency = myCategories[categoryTargetId].currency
    //
    //        // если валюты равны то делаем как обычно
    //        if accountCurrency == categoryCurrency {
    //            myAccounts[id].amountOfMoney -= Double(textField.textInput.text!)!.rounded(toPlaces: 2)
    //        } else {
    //            do {
    //                try convert(from: myAccounts[id],
    //                            to: myCategories[categoryTargetId],
    //                            amount: Double(textField.textInput.text!)!)
    //            } catch {
    //                print(error)
    //            }
    //
    //        }
    //    }

    func plusCategories(_ amount: Double) {
        guard let categoryTargetId = self.categoryTargetId else {
            fatalError("couldnt find id for category")
        }
        myCategories[categoryTargetId].amountOfMoney += amount
    }

    //    //MARK: - Navigation
    //    @IBAction func unwindToDetailHomeView( _ sender: UIStoryboardSegue) {}
    //    @IBAction func unwindToDetailHomeViewWithInfo( _ sender: UIStoryboardSegue) {}
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "chooseAccountFromDetail" {
    //            guard let next = segue.destination as? ChooseAccountUIViewController else {
    //                fatalError("segue not found")
    //            }
    //            next.homeDelegate = self
    //        }
    //    }

    //MARK: - IBActions
    @IBAction func chooseAccount(_ sender: UIButton) {

        // переход на выбор аккаунта
        performSegue(withIdentifier: "chooseAccountFromDetail", sender: nil)

    }

    //    @IBAction func buttons(_ sender: UIButton) {
    //        switch sender.tag {
    //        case 0...9:
    //            self.textField.textInput.text?.append("\(sender.tag)")
    //        case 10:
    //            self.textField.textInput.text?.append(".")
    //        case 11:
    //            do {
    //                // проверка, что всё чётко
    //                try checkForValidation()
    //
    //                // списываем деньги с accounts
    //                //MARK: - TO DO сначала нужно перевести эти деньги, которые списываем в валюту аккаунта
    //                takeAwayFromAccount()
    //
    //                // зачисляем в categories
    //                let money = Double(self.textField.textInput.text!)!
    //                plusCategories(money)
    //
    //                //MARK: - Здесь создание экземпляра операции
    //                myOperations.append(Operations(category: myCategories[categoryTargetId ?? 0],
    //                                               account: myAccounts[accountTargetId ?? 0],
    //                                               amountOfMoney: money,
    //                                               currency: myCategories[categoryTargetId ?? 0].currency,
    //                                               date: Date()))
    //
    //                // обновляем данные в accounts
    //                NotificationCenter.default.post(name: .userDataWasUpdated,
    //                                                object: nil,
    //                                                userInfo: nil)
    //
    //                // обновляем данные в categories
    //                NotificationCenter.default.post(name: .dataUpdatedFromHome,
    //                                                object: nil,
    //                                                userInfo: nil)
    //
    //                NotificationCenter.default.post(name: .operationsUpdate,
    //                                                object: nil,
    //                                                userInfo: nil)
    //
    //                // непосредственно переход
    //                homeOkPressed()
    //
    //            } catch {
    //                //вызываем singleton
    //                LNAlertHelper.shared.show(
    //                    for: self,
    //                    title: "Error",
    //                    message: error.localizedDescription,
    //                    secondButtonTitle: "Ok",
    //                    secondButtonAction: {
    //                        print("Alert was closed")
    //                    })
    //            }
    //        default:
    //            return
    //        }
    //    }
    //}
    //

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

extension HomeDetailViewController: ChooseAccountDetailViewControllerDelegate {
    func updateAccountTarget(_ accountId: Int) {
        //        self.accountTargetId = accountId
        //        self.modalView.fromButton.setImage(myAccounts[accountId].image.getImage(), for: .normal)
    }
}

