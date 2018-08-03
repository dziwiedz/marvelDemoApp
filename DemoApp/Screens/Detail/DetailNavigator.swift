//
//  DetailNavigator.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import UIKit

protocol DetailNavigating {
    func toMain()
}

final class DetailNavigator: DetailNavigating {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toMain() {
        navigationController.popViewController(animated: true)
    }
}
