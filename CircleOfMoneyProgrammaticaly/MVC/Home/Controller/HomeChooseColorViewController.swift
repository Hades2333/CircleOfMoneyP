//
//  HomeChooseColorViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class HomeChooseColorViewController: UIViewController {

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

        collection.register(ChooseColorCollectionViewCell.nib(),
                            forCellWithReuseIdentifier: ChooseColorCollectionViewCell.identifier)
        collection.backgroundColor = UIColor(named: "mainBackgoundColor")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    //MARK: - Properties
    var chooseColorTempColor = UIColor()
    var tapGesture = UITapGestureRecognizer()

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

    //MARK: - Navigation
    func next() {
        let next = HomeChooseIconViewController()

        next.modalTransitionStyle = .coverVertical
        next.modalPresentationStyle = .fullScreen
        next.modalPresentationStyle = .overCurrentContext
        next.chooseIconTempColor = chooseColorTempColor
        present(next, animated: false, completion: nil)
    }

    @objc private func tapped() {
        dismiss(animated: false, completion: nil)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension HomeChooseColorViewController: UIGestureRecognizerDelegate {

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
extension HomeChooseColorViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsForAccounts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChooseColorCollectionViewCell.identifier, for: indexPath) as? ChooseColorCollectionViewCell
        else { fatalError("lol") }
        cell.configureColorCell(with: colorsForAccounts[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeChooseColorViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        chooseColorTempColor = colorsForAccounts[indexPath.row]
        next()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeChooseColorViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}
