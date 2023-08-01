//
//  HomeViewModel.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel: BaseViewModel, ViewModelTransform {

    private let network = Networking()
    
    func transform(input: Input) -> Output {
        let request: Observable<[Video]> = network.request(with: .getVideos)

        let videos = request.asDriverOnErrorJustComplete()

        let error = request.getNetworkError()
            .compactMap({ $0.errorDescription })
            .asDriverOnErrorJustComplete()

        return Output(videos: videos,
                      error: error)
    }
}

extension HomeViewModel {
    struct Input {

    }

    struct Output {
        let videos: Driver<[Video]>
        let error: Driver<String>
    }
}
