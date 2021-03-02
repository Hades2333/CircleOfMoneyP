//
//  HomeChooseIconViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class HomeChooseIconViewController: UIViewController {

    //MARK: - GUI Variables
    lazy var modalView: ChooseIconView = {
        let view = ChooseIconView()
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)

        let collection = UICollectionView(frame: UIScreen.main.bounds,
                                          collectionViewLayout: layout)

        collection.register(ChooseIconCollectionViewCell.nib(),
                            forCellWithReuseIdentifier: ChooseIconCollectionViewCell.identifier)
        collection.backgroundColor = UIColor(named: "mainBackgoundColor")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()

    var chooseIconTempColor = UIColor()
    var chooseIconTempImage = UIImage()

    //MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        view.addSubview(self.modalView)
        self.modalView.addSubview(self.collectionView)

        modalView.snp.makeConstraints { (make) in
            self.modalView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().inset(100)
                make.bottom.equalToSuperview().inset(150)
                make.left.right.equalToSuperview().inset(35)
            }
        }

        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(modalView.chooseIconLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
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

    func next() {
        let next = HomeChooseNameViewController()

        next.modalTransitionStyle = .coverVertical
        next.modalPresentationStyle = .fullScreen
        next.modalPresentationStyle = .overCurrentContext

        next.mySelectedImage = chooseIconTempImage
        next.selectedColor = chooseIconTempColor

        present(next, animated: false, completion: nil)
    }

    @objc private func tapped() {
        let p = self.presentingViewController
        self.dismiss(animated: false) {
            p?.dismiss(animated: false, completion: nil)
        }
    }
}

//MARK: - UIGestureRecognizerDelegate
extension HomeChooseIconViewController: UIGestureRecognizerDelegate {

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

//MARK: - UICollectionViewDataSource
extension HomeChooseIconViewController: UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsForAccounts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChooseIconCollectionViewCell.identifier, for: indexPath) as? ChooseIconCollectionViewCell
        else { fatalError("lol") }

        cell.configureCICell(with: UIImage(named: "\(indexPath.row)")?
                                .withTintColor(chooseIconTempColor) ?? .checkmark)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeChooseIconViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        // выбранная фотка
        chooseIconTempImage = UIImage(named: "\(indexPath.row)")!
            .withTintColor(chooseIconTempColor)

        next()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeChooseIconViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}
