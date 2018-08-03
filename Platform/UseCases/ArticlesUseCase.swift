//
//  ArticlesUseCase.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import RxSwift
import Domain


final internal class ArticlesUseCase : Domain.ArticlesUseCase {
    
    private let articleProvider : ArticleNetworkProviding
    private let scheduler =  ConcurrentDispatchQueueScheduler(qos: .background)
    
    init(articleProvider: ArticleNetworkProviding) {
        self.articleProvider = articleProvider
    }
    
    func getArticles() -> Observable<[ArticleDTO]> {
        return articleProvider
            .provideArticles()
            .observeOn(scheduler)
            .map{ $0.map{ ArticleDTO(article: $0) }
        }
    }
    
    
}
