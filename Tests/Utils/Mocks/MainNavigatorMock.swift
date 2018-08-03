//
//  MainNavigatorMock.swift
//  DemoAppTests
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain
@testable import DemoApp

class MainNavigatorMock: MainNavigating {
    var invokedToDetail: Bool = false
    func toDetail(of article: ArticleDTO) {
        invokedToDetail = true
    }
}
