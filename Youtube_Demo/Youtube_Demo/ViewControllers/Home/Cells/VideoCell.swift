//
//  VideoCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 30/07/2023.
//

import UIKit

class VideoCell: UICollectionViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        thumbnailImageView.image = UIImage(named: "taylor_swift_blank_space")
        userProfileImageView.image = UIImage(named: "taylor_swift_profile")
    }
}
