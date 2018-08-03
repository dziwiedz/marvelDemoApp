//
//  ErrorPresenting.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import UIKit

protocol ErrorPresenting {
    func presentErrorAlert(message: String, title: String, okAction: (() -> Void)?)
}

extension ErrorPresenting where Self : UIViewController {
    func presentErrorAlert(message: String, title: String, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.ok, style: .default) { (_) in
            guard let okAction = okAction else { return }
            okAction()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
