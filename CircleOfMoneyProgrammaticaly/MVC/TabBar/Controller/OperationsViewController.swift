//
//  OperationsViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class OperationsViewController: UIViewController {

    //MARK: - Variables
    var delegate: GetRootNavDelegate?
    
    //MARK: - GUI Variables
    private lazy var operationTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "mainBackgroundColor")
        table.register(OperationTableViewCell.nib(),
                       forCellReuseIdentifier:  OperationTableViewCell.identifier)
        return table
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logOut")?.withTintColor(.red),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(self.backButtonPressed))
        
        tuneViews()
        NotificationCenter.default.addObserver(self ,
                                               selector: #selector(updateOperations),
                                               name: .operationsUpdate,
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(Notification.Name.operationsUpdate)
    }

    //MARK: - Methods
    @objc func backButtonPressed() {
        guard let firstStack = delegate?.getRootNav() else { return }
        let root = firstStack.viewControllers[0]
        firstStack.popToViewController(root, animated: false)
    }
    
    func tuneViews() {
        self.operationTable.dataSource = self
        self.operationTable.delegate = self

        self.edgesForExtendedLayout = []
        view.addSubview(self.operationTable)

        self.operationTable.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    @objc func updateOperations() {
        self.operationTable.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension OperationsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            myOperations.remove(at: indexPath.row)
            operationTable.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            return
        }
    }
}

//MARK: - OperationsViewController
extension OperationsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myOperations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OperationTableViewCell.identifier,
                for: indexPath ) as? OperationTableViewCell else {
            fatalError("Misconfigured cell type for cell!")
        }
        cell.configureOperations(myOperations[indexPath.row])
        return cell
    }

}
