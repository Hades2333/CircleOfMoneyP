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
        view.minusAction = { [weak self] in
            self?.minusPressed()
        }
        view.plusAction = { [weak self] in
            self?.plusPressed()
        }
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

        updateDetailValue()
        setupGestures()

        view.addSubview(self.modalView)
        self.modalView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(170)
        }
    }

    override func viewDidLayoutSubviews() {
        self.modalView.viewForAccountImage.layer.cornerRadius = self.modalView.viewForAccountImage.layer.bounds.width / 2
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

    func transferDetailValue(_ image: UIImage,
                             _ name: String,
                             _ amount: String,
                             _ indexPath: Int) {
        self.intermediateImage = image
        self.intermediateName = name
        self.intermediateAmount = amount
        self.id = indexPath
    }
    
    func updateDetailValue() {
        self.modalView.accountImage.image = intermediateImage
        self.modalView.accountName.text = intermediateName
        self.modalView.accountAmountOfMoney.text = intermediateAmount
    }

    @objc func tapped() {
        dismiss(animated: true, completion: nil)
    }

    //MARK: - Navigation
    func minusPressed() {
        let next = CalculatorViewController()

        next.modalTransitionStyle = .coverVertical
        next.modalPresentationStyle = .overCurrentContext

        guard let existingId = self.id else { fatalError("id not found") }

        next.transferGUI(self.intermediateImage ?? UIImage(named: "error")!,
                         UIImage(named: "onlyMinus") ?? UIImage(named: "error")!,
                         existingId)

        present(next, animated: false, completion: nil)
    }

    func plusPressed() {
        let next = CalculatorViewController()

        next.modalTransitionStyle = .coverVertical
        next.modalPresentationStyle = .overCurrentContext

        guard let existingId = self.id else { fatalError("id not found") }

        next.transferGUI(self.intermediateImage ?? UIImage(named: "error")!,
                         UIImage(named: "onlyPlus") ?? UIImage(named: "error")!,
                         existingId)

        present(next, animated: false, completion: nil)
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

