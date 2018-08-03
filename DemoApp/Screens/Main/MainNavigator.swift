//
//  MainNavigator.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

protocol MainNavigating {
    func toDetail(of article: ArticleDTO)
}

final class MainNavigator: MainNavigating {
    
    //    MARK: - Depenendencies
    private let useCaseProvider: UseCaseProvider
    private let navigationController: UINavigationController
    
    public init(useCaseProvider: UseCaseProvider, navigationController: UINavigationController) {
        self.useCaseProvider = useCaseProvider
        self.navigationController = navigationController
    }
    
    func toDetail(of article: ArticleDTO) {
        let navigator = DetailNavigator(navigationController: navigationController)
        let controller = DetailViewController(articleDto: article, navigator: navigator)
        navigationController.pushViewController(controller, animated: true)
    }
}
