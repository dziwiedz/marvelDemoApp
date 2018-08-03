//
//  ArticleUseCaseSpec.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import Domain
@testable import Platform

class ArticleUseCaseSpec: QuickSpec {
    override func spec() {
        describe("Use case tests") {
            context("success scenario", {
                let itemsCount = 3
                let provider = ArticleNetworkProviderMock(returnedItemsCount: itemsCount)
                let useCase = ArticlesUseCase(articleProvider: provider)
                it("Should return values", closure: {
                    var returnedItems: [ArticleDTO] = []
                    expect{ returnedItems = try useCase.getArticles().toBlocking().single()}.toEventuallyNot(throwError())
                    expect(returnedItems.count).to(equal(itemsCount))
                })
            })
            
            context("failure scenario", {
                let provider = ErrorArticleNetworkProviderMock(errorToThrow: UnknownError())
                let useCase = ArticlesUseCase(articleProvider: provider)
                it("should throw an unknown error", closure: {
                    expect{ try useCase.getArticles().toBlocking().single() }.to(throwError(errorType: UnknownError.self))
                })
            })
            
        }
    }
}
