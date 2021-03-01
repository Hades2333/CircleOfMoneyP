//
//  DetailLookAtCellViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class DetailLookAtCellViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var modalView: DetailLookAtCellView = {
        let view = DetailLookAtCellView()
        return view
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()

    var intermediateImage: UIImage?
    var intermediateName: String?
    var intermediateAmount: String?
    private var id: Int?

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //updateDetailValue()
        setupGestures()

        view.addSubview(self.modalView)
        self.modalView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(170)
        }
    }

//    override func viewDidLayoutSubviews() {
//        self.viewForAccountImage.layer.cornerRadius = self.viewForAccountImage.layer.bounds.width / 2
//    }

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

    func transferDetailValue(_ image: UIImage,
                             _ name: String,
                             _ amount: String,
                             _ indexPath: Int) {
        self.intermediateImage = image
        self.intermediateName = name
        self.intermediateAmount = amount
        self.id = indexPath
    }

//    func updateDetailValue() {
//        self.accountImage.image = intermediateImage
//        self.accountName.text = intermediateName
//        self.accountAmountOfMoney.text = intermediateAmount
//    }

    @objc func tapped() {
        dismiss(animated: true, completion: nil)
    }

    //MARK: - Navigation
//    @IBAction func unwindToTheDetailLook( _ sender: UIStoryboardSegue) {}
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let mySender = sender as? UIButton else { return }
//        //guard let next = segue.destination as? CalculatorViewController else { return }
//        guard let existingImage = intermediateImage else { fatalError("image not found") }
//        guard let existingId = self.id else { fatalError("id not found") }
//        switch mySender.tag {
//        case 1001:
//            next.transferGUI(existingImage, UIImage(named: "onlyMinus") ?? existingImage,
//                             existingId)
//        case 1002:
//            next.transferGUI(existingImage, UIImage(named: "onlyPlus") ?? existingImage,
//                             existingId)
//        default:
//            return
//        }
//    }

    //MARK: - IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "transferButtonPressed", sender: sender)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension DetailLookAtCellViewController: UIGestureRecognizerDelegate {

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

