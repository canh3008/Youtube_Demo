//
//  HomeCell.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 06/08/2023.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet private weak var tableView: UITableView!

    private var videos: [Video] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func config(with videos: [Video]) {
        self.videos = videos
    }

    private func setupCollectionView() {
        tableView.register(nibWithCellClass: VideoCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 300
    }
}

extension HomeCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: VideoCell.self, for: indexPath)
        cell.widthImageConstraints.constant = self.frame.width - 20
        cell.config(with: videos[indexPath.row])
        return cell
    }
}
