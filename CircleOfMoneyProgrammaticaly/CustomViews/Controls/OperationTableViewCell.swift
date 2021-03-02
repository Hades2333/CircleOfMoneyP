//
//  OperationTableViewCell.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 2.03.21.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    //MARK: - Preperties for easy registration
    static let identifier =  "OperationTableViewCell"

    //MARK: - Methods for easy registration
    static func nib() -> UINib {
        return UINib(nibName: "OperationTableViewCell", bundle: nil)
    }

    public func configureOperations(_ account: Operations) {
        self.categoryImage.image = account.category.image.getImage(with: account.category.color.uiColor)!
        self.categoryLabel.text = account.category.nameOfAccount

        self.accountImage.image = account.account.image.getImage()
        self.accountLabel.text = account.account.nameOfAccount

        self.moneyLabel.text = "\(account.amountOfMoney) \(account.currency)"

        let format = DateFormatter()
        format.dateFormat = "MM-dd-yyyy HH:mm"
//account.date
        self.dateLabel.text = String("\(format.string(from: account.date))")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

