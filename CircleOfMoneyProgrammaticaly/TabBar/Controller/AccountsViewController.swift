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

        view.backgroundColor = UIColor(named: "mainBackgoundColor")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if myAccounts.count == indexPath.row {
            let next = ChooseIconViewController()

            next.modalTransitionStyle = .coverVertical
            next.modalPresentationStyle = .fullScreen
            next.modalPresentationStyle = .overCurrentContext

            self.present(next, animated: false, completion: nil)

        } else {
            performSegue(withIdentifier: "DetailLook", sender: indexPath)
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
