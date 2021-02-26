//
//  ViewController.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 19.02.21.
//

import UIKit
import SnapKit

class FirstScreenViewController: UIViewController {

    //MARK: - GUI Variables
    private lazy var firstScreenView: FirstScreenUIView = {
        let view = FirstScreenUIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(firstScreenView)
        self.firstScreenView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()  
        }
    }


}

