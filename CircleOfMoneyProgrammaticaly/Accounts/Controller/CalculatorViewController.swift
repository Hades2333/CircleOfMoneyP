//
//  CalculatorViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class CalculatorViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var modalView: CalculatorView = {
        let view = CalculatorView()
        return view
    }()

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        view.addSubview(self.modalView)

        self.modalView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(118)
        }
        self.modalView.layer.cornerRadius = 25.0
    }
}
//    //MARK: - Properties
//    var tapGesture = UITapGestureRecognizer()
//
//    private var tempFromImage: UIImage?
//    private var tempOperationImage: UIImage?
//    private var id: Int?
//
//    //MARK: - Lifecycle
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupGestures()
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.view.removeGestureRecognizer(tapGesture)
//    }
//
//    override func viewDidLayoutSubviews() {
//        configureElements()
//        updateGUI()
//    }
//
//    //MARK: - Methods
//    func configureElements() {
//        self.calculatorButtons.forEach {
//            $0.backgroundColor = UIColor(named: "mainBackgroundColor")
//            $0.tintColor = UIColor(named: "greenLittleTint")
//            $0.titleLabel?.font = UIFont(name: "Varela", size: 20.0)
//            $0.layer.cornerRadius = self.calculatorButtons[0].bounds.height / 2
//            $0.layer.masksToBounds = false
//            $0.layer.shadowColor = UIColor.black.cgColor
//            $0.layer.shadowOpacity = 0.5
//            $0.layer.shadowOffset = .zero
//            $0.layer.shadowRadius = 5
//        }
//        self.calculatorButtons[9].setTitle(".", for: .normal)
//        self.calculatorButtons[11].setTitle("Ok", for: .normal)
//
//        self.modalView.layer.cornerRadius = 20.0
//    }
//
//    func setupGestures() {
//        tapGesture = UITapGestureRecognizer(target: self,
//                                            action: #selector(tapped))
//        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func tapped() {
//        performSegue(withIdentifier: "toTheDetailLook", sender: nil)
//    }
//
//    func transferGUI(_ from: UIImage,
//                     _ operation: UIImage,
//                     _ id: Int) {
//        self.tempFromImage = from
//        self.tempOperationImage = operation
//        self.id = id
//    }
//
//    func updateGUI() {
//        self.fromImage.image = tempFromImage
//        self.operationImage.image = tempOperationImage
//    }
//
//
//    func okPressed(with number: Double) {
//        //MARK: - TO DO тут нужен делегат чтобы увеличить или уменьшить значения в массиве
//        guard let existingId = self.id else { fatalError("id not found") }
//        myAccounts[existingId].amountOfMoney += number.rounded(toPlaces: 2)
//        performSegue(withIdentifier: "backToTheAccounts", sender: nil) // тут выходим обратно
//    }
//
//    //MARK: - Navigation
//    // делаем reload
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "backToTheAccounts" {
//            guard let next = segue.destination as? AccountsViewController else { fatalError() }
//            next.table.reloadData()
//        }
//    }
//
//    //MARK: - IBActions
//    @IBAction func buttonPressed(_ sender: UIButton) {
//        switch sender.tag {
//        case 0...9:
//            self.textField.textInput.text?.append("\(sender.tag)")
//        case 10:
//            self.textField.textInput.text?.append(".")
//        case 11:
//            do {
//                let sign = self.operationImage.image == UIImage(named: "onlyPlus") ? "+" : "-"
//                try okPressed(with: numberIsValid(self.textField, sign))
//            } catch {
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
////MARK: - UIGestureRecognizerDelegate
//extension CalculatorViewController: UIGestureRecognizerDelegate {
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
//                           shouldReceive touch: UITouch) -> Bool {
//
//        if let touchView = touch.view {
//            if touchView.isDescendant(of: modalView){
//                return false
//            }
//        }
//        return true
//    }
//}
//

