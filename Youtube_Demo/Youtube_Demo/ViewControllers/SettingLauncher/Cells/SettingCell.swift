//
//  SettingCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(with setting: Setting) {
        iconImageView.image = UIImage(named: setting.nameImage)
        titleLabel.text = setting.name
    }
    
}
