//
//  HomeController.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 29/07/2023.
//

import UIKit
import SwifterSwift

class HomeController: BaseViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func setupUI() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home.title".localized()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        setupNavigationBar()
    }

    override func bindingData() {

    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: VideoCell.self)
    }

    private func setupNavigationBar() {
        if #available(iOS 15, *) {
            // Navigation Bar background color
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .red
            // setup title font color
            //                let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.yourColor]
            //                appearance.titleTextAttributes = titleAttribute

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = .red
            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().isTranslucent = false
        }

//        if #available(iOS 13, *)
//              {
//                  let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
//                  statusBar.backgroundColor = #colorLiteral(red: 0.2346, green: 0.3456, blue: 0.5677, alpha: 1)
//                  UIApplication.shared.keyWindow?.addSubview(statusBar)
//              } else {
//                 // ADD THE STATUS BAR AND SET A CUSTOM COLOR
//                  let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView ?? UIView()
//                 if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
//                    statusBar.backgroundColor = #colorLiteral(red: 0.2346, green: 0.3456, blue: 0.5677, alpha: 1)
//                 }
//                 UIApplication.shared.statusBarStyle = .lightContent
//              }
    }

}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: VideoCell.self, for: indexPath)
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }

}
