//
//  UIImageView+Extension.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with path: String) {
        let source = URL(string: path)
        kf.setImage(with: source, placeholder: nil, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let data):
                self.image = data.image
            case .failure(let error):
                fatalError("fetch image not success")
            }
        }
    }
}
