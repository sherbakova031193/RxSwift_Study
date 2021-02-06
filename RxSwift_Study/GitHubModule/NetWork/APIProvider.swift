//
//  APIProvider.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 06.02.2021.
//

import Foundation
import RxSwift

class APIProvider {
    
    func getRepositories(_ githudID: String) -> Observable<[Repository]> {
        guard !githudID.isEmpty,
              let url = URL(string: "https://api.github.com/users/\(githudID)/repos")
        else {
            return Observable.just([])
        }
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(3)
            .catchAndReturn(Observable.just([]))
            .map {
                var repositories = [Repository]()
                if let items = $0 as? [[String: AnyObject]] {
                    items.forEach {
                        guard let name = $0["name"] as? String,
                              let url = $0["html_url"] as? String
                        else { return }
                        repositories.append(Repository(name: name, url: url))
                    }
                }
                return repositories
            }
    }
}
