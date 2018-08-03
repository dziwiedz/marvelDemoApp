//
//  GetTopArticlesCase.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import RxSwift

public protocol ArticlesUseCase {
    func getArticles() -> Observable<[ArticleDTO]>
}
