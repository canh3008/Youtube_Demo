//
//  ContentSizedTableView.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 02/08/2023.
//

import UIKit

final class ContentSizedTableView: UITableView {

    @IBInspectable var maxHeight: CGFloat = 100

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: max(contentSize.height, maxHeight))
    }
}
