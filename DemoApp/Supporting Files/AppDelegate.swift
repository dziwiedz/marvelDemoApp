//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import UIKit
import Platform

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = MainViewController()
        let nav = UINavigationController(rootViewController: rootViewController)
        
        UIApplication.shared.statusBarStyle = .lightContent
        nav.navigationBar.barTintColor = UIColor.demoWhite
        nav.navigationBar.tintColor = UIColor.demoRed
        let titleDict: Dictionary = [NSAttributedStringKey.foregroundColor: UIColor.demoRed]
        nav.navigationBar.titleTextAttributes = titleDict
        nav.navigationBar.isTranslucent = false
        
        let useCaseProvider = Platform.UseCaseProvider()
        let mainNavigator = MainNavigator(useCaseProvider: useCaseProvider, navigationController: nav)
        let viewModel = MainViewModel(articleProvider: useCaseProvider.makeArticleUseCase(), navigator: mainNavigator)
        rootViewController.viewModel = viewModel
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}

