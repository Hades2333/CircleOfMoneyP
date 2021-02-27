//
//  LogInViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 27.02.21.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    //MARK: - GUI Variables
    private lazy var logInView: LogInView = {
        let view = LogInView()
        view.backTransition = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.logInTransition = { [weak self] in
        }
        return view
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.view.addSubview(logInView)
        self.logInView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
