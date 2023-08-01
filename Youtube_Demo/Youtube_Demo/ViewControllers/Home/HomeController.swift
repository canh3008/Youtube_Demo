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

    private lazy var videos = [Video]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        setupNavigationBarButtons()
    }

    override func bindingData() {
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input: input)
        output.videos.drive { [weak self] videos in
            guard let self = self else {
                return
            }
            self.videos = videos
        }
        .disposed(by: disposeBag)

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

    private func setupNavigationBarButtons() {
        let searchImage = UIImage(named: "seach_icon")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage,
                                           style: .done,
                                           target: self,
                                           action: #selector(handleSearch))

        let moreImage = UIImage(named: "more_menu_icon")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage,
                                           style: .done,
                                           target: self,
                                           action: #selector(handleSearch))

        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }

    @objc private func handleSearch() {

    }

    @objc private func handleMore() {

    }

}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: VideoCell.self, for: indexPath)
        cell.config(with: videos[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }

}
