//
//  ArticleNetworkProvider.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import RxSwift
import Domain

protocol ArticleNetworkProviding {
    func provideArticles() -> Observable<[Article]>
}

final class ArticleNetworkProvider: ArticleNetworkProviding {
    
    private let requester: ApiGetting
    
    init(requester: ApiGetting) {
        self.requester = requester
    }
    
    func provideArticles() -> Observable<[Article]> {
        return requester
            .makeRequest()
            .mapObject(toType: ArticlesResponse.self)
            .map { $0.items }
    }
}
