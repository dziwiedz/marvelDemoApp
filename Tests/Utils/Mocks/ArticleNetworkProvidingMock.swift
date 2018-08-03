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
    var providerCalled: Bool = false
    
    init(errorToThrow: Error = UnknownError()) {
        self.errorToThrow = errorToThrow
    }
    
    func provideArticles() -> Observable<[Article]> {
        providerCalled = true
        return Observable.just([]).map{ [unowned self] _ in throw self.errorToThrow }
    }
}

class ArticleNetworkProviderMock: ArticleNetworkProviding {
    
    private let fileName = "ArticleSample"
    var items: [Article] = []
    var returnedItemsCount : Int = 0
    var providerCalled: Bool = false
    
    init(returnedItemsCount: Int) {
        self.returnedItemsCount = returnedItemsCount
    }
    
    func provideArticles() -> Observable<[Article]> {
        providerCalled = true
        let article = JsonObjectLoader<Article>.loadObject(fromJsonFileName: fileName)
        self.items = []
        for _ in 0..<returnedItemsCount { self.items.append(article) }
        return Observable.just(items)
    }
}
