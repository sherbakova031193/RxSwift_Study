//
//  ViewModel.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
    
    let searchText = BehaviorRelay<String>(value: "")
    
    let apiProvider: APIProvider
    var data: Driver<[Repository]>
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
        self.data = self.searchText.asObservable()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                apiProvider.getRepositories($0)
            }.asDriver(onErrorJustReturn: [])
    }
}

