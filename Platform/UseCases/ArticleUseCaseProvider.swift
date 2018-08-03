//
//  ArticleUseCaseProvider.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

final class ArticlesUseCaseProvider : Domain.ArticlesUseCaseProvider {
    
    private let requester: ArticleRequster
    private let networkProvider: ArticleNetworkProvider
    
    public init() {
        self.requester = ArticleRequster()
        self.networkProvider = ArticleNetworkProvider(requester: requester)
    }
    
    public func provideArticleUseCase() -> Domain.ArticlesUseCase {
        return ArticlesUseCase(articleProvider: networkProvider)
    }
    
    
}
