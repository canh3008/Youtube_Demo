//
//  VideoCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 30/07/2023.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    @IBOutlet weak var widthImageConstraints: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func config(with video: Video) {
        thumbnailImageView.setImage(with: video.thumbnailImageName ?? "")
        self.titleLabel.text = video.title
        let numbers = (video.numberOfViews ?? 0).convertDecimalNumber()
        self.subTitleLabel.text = (video.channel?.name ?? "") + " - " + numbers + " - 2 years ago"
        userProfileImageView.setImage(with: video.channel?.profileImageName ?? "")
    }
}
