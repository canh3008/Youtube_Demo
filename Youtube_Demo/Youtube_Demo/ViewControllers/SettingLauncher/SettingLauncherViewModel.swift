//
//  SettingLauncherViewModel.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

class SettingLauncherViewModel: BaseViewModel, ViewModelTransform {
    func transform(input: Input) -> Output {
        let model = Driver.just(SettingType.allCases)
        return Output(settings: model)
    }
}

extension SettingLauncherViewModel {
    struct Input {

    }

    struct Output {
        let settings: Driver<[SettingType]>
    }
}
