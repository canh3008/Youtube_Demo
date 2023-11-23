//
//  MenuCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 31/07/2023.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isHighlighted: Bool {
        didSet {
            iconView.tintColor = isHighlighted ? .white : .black
        }
    }

    override var isSelected: Bool {
        didSet {
            iconView.tintColor = isSelected ? .white : .black
        }
    }

    func config(with nameImage: String) {
        iconView.image = UIImage(named: nameImage)?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .black
    }

}
