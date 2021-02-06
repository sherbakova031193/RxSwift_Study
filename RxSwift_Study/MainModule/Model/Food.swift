//
//  Food.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import UIKit
import RxDataSources

struct Food {
    let name: String
    let flickrID: String
    var image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
        self.image = UIImage(named: flickrID)
    }
}

//extension Food: CustomStringConvertible {
//    var description: String {
//        return "\(name): flickr.com/\(flickrID)"
//    }
//}

extension Food: IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return flickrID }

}
