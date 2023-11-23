//
//  BaseViewController.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 30/07/2023.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        setupUI()
        bindingData()
    }

    func setupUI() {

    }

    func bindingData() {

    }
}
