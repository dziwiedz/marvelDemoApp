//
//  ArticleUseCaseProviderMock.swift
//  DemoAppTests
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain
import RxSwift
@testable import DemoApp

class ArticlesUseCaseMock: ArticlesUseCase {
    private let fileName = "ArticleSample"
    var itemsCount: Int = 0
    var items: [ArticleDTO] = []
    init(itemsCount: Int) {
        self.itemsCount = itemsCount
    }
    
    func getArticles() -> Observable<[ArticleDTO]> {
        items = []
        let article = JsonObjectLoader<Article>.loadObject(fromJsonFileName: fileName)
        for _ in 0..<itemsCount {
            items.append(ArticleDTO(article: article))
        }
        return Observable.just(items)
    }
    
}

class ArticlesUseCaseWithErrorMock: ArticlesUseCase {
    func getArticles() -> Observable<[ArticleDTO]> {
        return Observable.just([]).map{ _ in throw UnknownError() }
    }
    
}
