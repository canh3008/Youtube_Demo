//
//  MenuBar.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 31/07/2023.
//

import UIKit

class MenuBar: BaseView {

    @IBOutlet weak var collectionView: UICollectionView!

    private let nameImages = ["home_icon", "fire_flame_icon", "playlist_icon 1", "person_icon"]

    override func initView() {
        super.initView()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: MenuCell.self)
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
        return CGSize(width: collectionView.frame.width / CGFloat(nameImages.count), height: collectionView.frame.height)
    }

}
