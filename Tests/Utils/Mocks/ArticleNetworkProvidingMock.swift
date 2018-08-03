//
//  ArticleNetworkProvidingMock.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import RxTest
import RxSwift
import RxBlocking
import Domain
@testable import Platform

class ErrorArticleNetworkProviderMock: ArticleNetworkProviding {
    
    var errorToThrow: Error
    
    init(errorToThrow: Error = UnknownError()) {
        self.errorToThrow = errorToThrow
    }
    
    func provideArticles() -> Observable<[Article]> {
        return Observable.just([]).map{ [unowned self] _ in throw self.errorToThrow }
    }
}

class ArticleNetworkProviderMock: ArticleNetworkProviding {
    
    private let fileName = "ArticleSample"
    var returnedItemsCount : Int = 0
    
    init(returnedItemsCount: Int) {
        self.returnedItemsCount = returnedItemsCount
    }
    
    func provideArticles() -> Observable<[Article]> {
        let article = JsonObjectLoader<Article>.loadObject(fromJsonFileName: fileName)
        var articles: [Article] = []
        for _ in 0..<returnedItemsCount { articles.append(article) }
        return Observable.just(articles)
    }
}
