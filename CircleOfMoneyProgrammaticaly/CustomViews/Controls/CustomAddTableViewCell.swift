//
//  CustomAddTableViewCell.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class CustomAddTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel! {
        didSet {
            self.label.font = UIFont(name: "Varela", size: 18.0)
            self.label.textColor = UIColor(named: "greenLittleTint")
        }
    }
    @IBOutlet weak var plusImage: UIImageView!

    //MARK: - Preperties for easy registration
    static let identifier =  "addCategoryCell"

    //MARK: - Methods for easy registration
    static func nib() -> UINib {
        return UINib(nibName: "CustomAddTableViewCell", bundle: nil)
    }

    public func configureAddCell(title: String) {
        label.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
