//
//  AccountsViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class AccountsViewController: UIViewController {

    //MARK: - Variables
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "mainBackgroundColor")
        table.separatorStyle = .none
        table.register(AccountTableViewCell.nib(),
                       forCellReuseIdentifier:  AccountTableViewCell.identifier)

        table.register(CustomAddTableViewCell.nib(),
                       forCellReuseIdentifier:  CustomAddTableViewCell.identifier)

        table.delegate = self
        table.dataSource = self
        return table
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        self.edgesForExtendedLayout = []

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        NotificationCenter.default.addObserver(self ,
                                               selector: #selector(sendDataWithObserver),
                                               name: .accountsDataWasUpdated,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(Notification.Name.accountsDataWasUpdated)
    }

    //MARK: - Methods
    @objc func sendDataWithObserver() {
        self.tableView.reloadData()
    }
}

extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if myAccounts.count == indexPath.row {
            let next = ChooseIconViewController()
            next.modalTransitionStyle = .coverVertical
            next.modalPresentationStyle = .overFullScreen
            self.present(next, animated: false, completion: nil)
        } else {
            let next = DetailLookAtCellViewController()

            next.transferDetailValue(myAccounts[indexPath.row].image.getImage()!,
                                     myAccounts[indexPath.row].nameOfAccount,
                                     "\(myAccounts[indexPath.row].amountOfMoney) \(myAccounts[indexPath.row].currency)", indexPath.row)
            
            next.modalTransitionStyle = .coverVertical
            next.modalPresentationStyle = .overFullScreen
            self.present(next, animated: false, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            myAccounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            return
        }
    }
}

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myAccounts.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let totalRows = tableView.numberOfRows(inSection: 0)
        if indexPath.row == totalRows - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomAddTableViewCell.identifier, for: indexPath) as? CustomAddTableViewCell else {
                fatalError("Misconfigured cell type for cell!")
            }
            cell.configureAddCell(title: "Add account")
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AccountTableViewCell.identifier,
                for: indexPath ) as? AccountTableViewCell else {
            fatalError("Misconfigured cell type for cell!")
        }
        cell.configureAccounts(myAccounts[indexPath.row])
        return cell
    }
}
