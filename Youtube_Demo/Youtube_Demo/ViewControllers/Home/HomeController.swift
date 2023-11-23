//
//  HomeController.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 29/07/2023.
//

import UIKit
import SwifterSwift

class HomeController: BaseViewController {

    @IBOutlet fileprivate weak var menuBar: MenuBar!
    @IBOutlet private weak var collectionView: UICollectionView!

    private lazy var features = [Feature]() {
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
        menuBar.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuBar.selectedFirstItem()
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
        output.datas.drive { [weak self] features in
            guard let self = self else {
                return
            }
            self.setupCollectionView()
            self.features = features

        }
        .disposed(by: disposeBag)

    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: HomeCell.self)
        collectionView.register(nibWithCellClass: TrendingCell.self)
        collectionView.register(nibWithCellClass: PlaylistCell.self)
        collectionView.register(nibWithCellClass: PersonCell.self)
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
                                           action: #selector(handleMore))

        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }

    @objc private func handleSearch() {

    }

    @objc private func handleMore() {
        let settingLauncherController = SettingLauncherViewController(viewModel: SettingLauncherViewModel())
        settingLauncherController.modalPresentationStyle = .overFullScreen
        settingLauncherController.modalTransitionStyle = .crossDissolve
        settingLauncherController.completion = { [weak self] type in
            print("zzzzzzz push view", type.model.name)
        }
        present(settingLauncherController, animated: true)
    }

}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feature = features[indexPath.row]
        switch feature {
        case .home(models: let models):
            let cell = collectionView.dequeueReusableCell(withClass: HomeCell.self, for: indexPath)
            cell.config(with: models)
            return cell
        case .trending(models: let models):
            let cell = collectionView.dequeueReusableCell(withClass: TrendingCell.self, for: indexPath)
            return cell
        case .playlist(models: let models):
            let cell = collectionView.dequeueReusableCell(withClass: PlaylistCell.self, for: indexPath)
            return cell
        case .person(models: let models):
            let cell = collectionView.dequeueReusableCell(withClass: PersonCell.self, for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, 
                      height: collectionView.frame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.x / scrollView.frame.width

        menuBar.scrollSlider(with: yOffset)
    }

//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let scrollY = scrollView.contentOffset.y
//        self.navigationController?.setNavigationBarHidden(scrollY > 40, animated: true)
//    }

}

extension HomeController: MenuBarDelegate {
    func didSelectedIndex(with index: Int) {
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(
            at: IndexPath(item: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        collectionView.isPagingEnabled = true

    }
}
