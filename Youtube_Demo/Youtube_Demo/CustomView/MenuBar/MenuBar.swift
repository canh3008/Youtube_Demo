//
//  MenuBar.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 31/07/2023.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelectedIndex(with index: Int)
}

class MenuBar: BaseView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftSliderConstraints: NSLayoutConstraint!

    private let nameImages = ["home_icon", "fire_flame_icon", "playlist_icon 1", "person_icon"]

    weak var delegate: MenuBarDelegate?

    override func initView() {
        super.initView()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: MenuCell.self)
    }

    func scrollSlider(with xRatio: CGFloat) {
        let xOffset = (collectionView.frame.width / CGFloat(nameImages.count)) * xRatio
        leftSliderConstraints.constant = xOffset
    }

    func selectedFirstItem() {
        let firstIndexPath: IndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .left)
    }

}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameImages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MenuCell.self, for: indexPath)
        cell.config(with: nameImages[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(nameImages.count),
                      height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedIndex(with: indexPath.row)
        let distance: CGFloat = CGFloat(indexPath.row) * (collectionView.frame.width / 4)
        leftSliderConstraints.constant = distance
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
