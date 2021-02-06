//
//  AnimatedSectionModel.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import Foundation
import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    typealias Item = String
    typealias Identity = String
    
    var identity: Identity { return title}
    var items: [Item] { return data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
}
