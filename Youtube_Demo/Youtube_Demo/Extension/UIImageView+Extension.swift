//
//  UIImageView+Extension.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with path: String, completion: (() -> Void)? = nil) {
        let source = URL(string: path)
        KF.url(source)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onSuccess { result in
              completion?()
          }
          .onFailure { error in }
          .set(to: self)
    }
}
