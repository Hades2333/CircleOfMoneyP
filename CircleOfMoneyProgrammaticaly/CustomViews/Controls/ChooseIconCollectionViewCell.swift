//
//  ChooseIconsCollectionViewCell.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

class ChooseIconCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    static let identifier = "ChooseIconCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configureCICell(with image: UIImage) {
        imageView.image = image
    }

    static func nib() -> UINib {
        return UINib(nibName: "ChooseIconCollectionViewCell",
                     bundle: nil)
    }
}
