//
//  Spinner.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 22/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import UIKit
import SnapKit

final class Spinner: UIView {
    
    //    MARK: - Subviews
    
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let label: UILabel = UILabel()
    
    //    MARK: - Variables
    
    public var text: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    public var color: UIColor {
        get { return label.textColor }
        set {
            label.textColor = newValue
            indicator.color = newValue
        }
    }
    
    //    MARK: - Public methods
    
    public func startAnimating() {
        indicator.startAnimating()
        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        })
    }
    
    public func stopAnimating() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { [weak self] (_) in
            self?.isHidden = true
            self?.indicator.stopAnimating()
        }
    }
    
    //    MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicator)
        addSubview(label)
        configureLayout()
        configureLabel()
        self.backgroundColor = UIColor.demoBlack.withAlphaComponent(0.7)
        self.layer.cornerRadius = 16
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Private methods
    
    private func configureLayout() {
        indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(LayoutConstants.spinnerHeight)
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(indicator.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureLabel() {
        label.textAlignment = .center
        label.textColor = .demoWhite
        indicator.color = .demoWhite
    }
}
