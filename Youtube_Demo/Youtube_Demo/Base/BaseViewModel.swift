//
//  BaseViewModel.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation
import RxSwift

protocol ViewModelTransform {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class BaseViewModel {
    var disposeBag = DisposeBag()
}
