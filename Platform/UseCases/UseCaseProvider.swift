//
//  UseCaseProvider.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider : Domain.UseCaseProvider {
    
    private let articlesCaseProvider: ArticlesUseCaseProvider
    
    public init() {
        self.articlesCaseProvider = ArticlesUseCaseProvider()
    }
    
    public func makeArticleUseCase() -> Domain.ArticlesUseCase {
        return articlesCaseProvider.provideArticleUseCase()
    }
    
    
}
