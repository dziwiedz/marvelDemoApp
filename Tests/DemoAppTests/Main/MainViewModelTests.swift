//
//  MainViewModelTests.swift
//  DemoAppTests
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import XCTest
import RxCocoa
import RxTest
import RxBlocking
import Nimble
import Domain

@testable import DemoApp

class MainViewModelTests: XCTestCase {
    
    var viewmodel: MainViewModel!
    let articleProvider = ArticlesUseCaseMock(itemsCount: 0)
    let navigator = MainNavigatorMock()
    
    override func setUp() {
        super.setUp()
        navigator.invokedToDetail = false
        articleProvider.itemsCount = 0
        articleProvider.items = []
        viewmodel = MainViewModel(articleProvider: articleProvider, navigator: navigator)
        viewmodel.bindReloading(Driver.just(()))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewmodel = nil
        super.tearDown()
    }

    func test_ifReturnsArticles() {
        let values = try! viewmodel.filteredArticles.toBlocking().first()!
        expect(values.count).to(equal(0))
    }
    
    func test_ifReturnsCorrectArticlesCount() {
        articleProvider.itemsCount = 3
        viewmodel.bindReloading(Driver.just(()))
        let values = try! viewmodel.filteredArticles.toBlocking().first()!
        expect(values.count).to(equal(articleProvider.itemsCount))
    }
    
//    None article is set as favorited
    func test_ifReturnsCorrectFilteredArticlesCount() {
        articleProvider.itemsCount = 3
        viewmodel.bindReloading(Driver.just(()))
        viewmodel.bindFilteringScope(Driver.just(.favorites))
        let values = try! viewmodel.filteredArticles.toBlocking().first()!
        expect(values.count).to(equal(0))
    }
    
}
