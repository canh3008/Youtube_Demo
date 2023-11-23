//
//  HomeViewModel.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation
import RxCocoa
import RxSwift

struct Trending {

}

struct Playlist {

}

struct Person {

}

enum Feature {
    case home(models: [Video])
    case trending(models: [Trending])
    case playlist(models: [Playlist])
    case person(models: [Person])
}

class HomeViewModel: BaseViewModel, ViewModelTransform {

    private let network = Networking()
    
    func transform(input: Input) -> Output {
        let request: Observable<[Video]> = network.request(with: .getVideos)

        let data = request
            .map({ [Feature.home(models: $0),
                    Feature.trending(models: [.init()]),
                    Feature.playlist(models: [.init()]),
                    Feature.person(models: [.init()])] })
            .asDriverOnErrorJustComplete()

        let videos = request.asDriverOnErrorJustComplete()

        let error = request.getNetworkError()
            .compactMap({ $0.errorDescription })
            .asDriverOnErrorJustComplete()

        return Output(datas: data,
                      error: error)
    }
}

extension HomeViewModel {
    struct Input {

    }

    struct Output {
        let datas: Driver<[Feature]>
        let error: Driver<String>
    }
}
