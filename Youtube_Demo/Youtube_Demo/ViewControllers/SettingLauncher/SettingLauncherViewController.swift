//
//  SettingLauncherViewController.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import UIKit

class SettingLauncherViewController: BaseViewController {

    @IBOutlet private weak var tableView: ContentSizedTableView!
    @IBOutlet private weak var emptyView: UIView!

    private var settingTypes = [SettingType]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let viewModel: SettingLauncherViewModel

    var completion: ((SettingType) -> Void)?

    init(viewModel: SettingLauncherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupTableView()
        addTapGesture()
    }

    override func bindingData() {
        super.bindingData()
        let input = SettingLauncherViewModel.Input()

        let output = viewModel.transform(input: input)
        output.settings
            .drive { [weak self] settingTypes in
                guard let self = self else {
                    return
                }
                self.settingTypes = settingTypes
            }
            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibWithCellClass: SettingCell.self)
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        emptyView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        dismiss(animated: true)
    }

}

extension SettingLauncherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SettingCell.self, for: indexPath)
        cell.config(with: settingTypes[indexPath.row].model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard settingTypes[indexPath.row] != .cancel else {
            dismiss(animated: true)
            return
        }
        dismiss(animated: true) { [weak self] in
            guard let self = self else {
                return
            }
            self.completion?(self.settingTypes[indexPath.row])
        }
    }
}
