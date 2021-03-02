//
//  HomeChooseAccountViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class HomeChooseAccountViewCotroller: UIViewController {

    //MARK: - Variables
    lazy var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        return view
    }()

    lazy var table: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "mainBackgroundColor")
        table.layer.cornerRadius = 20.0
        table.delegate = self
        table.dataSource = self
        table.register(AccountTableViewCell.nib(),
                       forCellReuseIdentifier:  AccountTableViewCell.identifier)
        return table
    }()

    //MARK: - Properties
    var tapGesture = UITapGestureRecognizer()
    weak var homeDelegate: HomeDetailViewControllerDelegate?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        view.addSubview(modalView)
        self.modalView.addSubview(self.table)

        self.modalView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(150)
            make.left.right.equalToSuperview().inset(35)
        }

        self.table.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
        self.modalView.layer.cornerRadius = 20.0
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
        dismiss(animated: false)
    }
}

extension HomeChooseAccountViewCotroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeDelegate?.updateAccountTarget(indexPath.row)
        tapped()
    }
}

extension HomeChooseAccountViewCotroller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myAccounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AccountTableViewCell.identifier,
                for: indexPath ) as? AccountTableViewCell else {
            fatalError("Misconfigured cell type for cell!")
        }
        cell.configureAccounts(myAccounts[indexPath.row])
        return cell
    }
}

extension HomeChooseAccountViewCotroller: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {

        if let touchView = touch.view {
            if touchView.isDescendant(of: table){
                return false
            }
        }
        return true
    }
}
