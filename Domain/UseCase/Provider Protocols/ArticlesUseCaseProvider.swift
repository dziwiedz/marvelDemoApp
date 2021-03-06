//
//  GetTopArticlesProvider.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public protocol ArticlesUseCaseProvider {
    func provideArticleUseCase() -> ArticlesUseCase
}
