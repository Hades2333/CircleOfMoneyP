//
//  AccountTableViewCell.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var date: UILabel!
    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var labelName: UILabel! {
        didSet {
            self.labelName.font = UIFont(name: "Varela", size: 18.0)
            self.labelName.textColor = UIColor(named: "greenLittleTint")
        }
    }
    @IBOutlet var labelMoney: UILabel! {
        didSet {
            self.labelMoney.font = UIFont(name: "Varela", size: 18.0)
            self.labelMoney.textColor = UIColor(named: "greenLittleTint")
        }
    }
    
    //MARK: - Preperties for easy registration
    static let identifier =  "AccountTableViewCell"
    
    //MARK: - Methods for easy registration
    static func nib() -> UINib {
        return UINib(nibName: "AccountTableViewCell", bundle: nil)
    }
    
    public func configureAccounts(_ account: Accounts) {
        labelName.text = account.nameOfAccount
        labelMoney.text = "\(account.amountOfMoney)   \(account.currency)"
        imageIcon.image = account.image.getImage()
    }
    
    public func configureCategories(_ account: Categories) {
        labelName.text = account.nameOfAccount
        labelMoney.text = "\(account.amountOfMoney)   \(account.currency)"
        imageIcon.image = account.image.getImage(with: account.color.uiColor)
    }
    
    public func configureOperations(_ account: Operations) {
        self.labelName.text = account.category.nameOfAccount
        self.labelMoney.text = "\(account.amountOfMoney)   \(account.currency)"
        self.imageIcon.image = account.category.image.getImage(with: account.category.color.uiColor)
        self.date.text = String("\(account.date)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
