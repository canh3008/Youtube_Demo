//
//  VideoCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 30/07/2023.
//

import UIKit

class VideoCell: BaseCollectionViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setupUI() {
        super.setupUI()
        thumbnailImageView.image = UIImage(named: "taylor_swift_blank_space")
        userProfileImageView.image = UIImage(named: "taylor_swift_profile")
    }

    func config(with video: Video) {
        thumbnailImageView.setImage(with: video.thumbnailImageName ?? "")
        titleLabel.text = video.title
        userProfileImageView.setImage(with: video.channel?.profileImageName ?? "")
        let numbers = (video.numberOfViews ?? 0).convertDecimalNumber()
        subTitleLabel.text = (video.channel?.name ?? "") + " - " + numbers + " - 2 years ago"
    }
}
