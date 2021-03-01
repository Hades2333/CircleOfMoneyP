//
//  ChooseColorCollectionViewCell.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 1.03.21.
//

import UIKit

class ChooseColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!

    static let identifier = "ChooseColorCollectionViewCell"

    //MARK: - Methods
    func configureColorCell(with color: UIColor) {
        self.colorView.backgroundColor = color
    }

    static func nib() -> UINib {
        return UINib(nibName: "ChooseColorCollectionViewCell",
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
