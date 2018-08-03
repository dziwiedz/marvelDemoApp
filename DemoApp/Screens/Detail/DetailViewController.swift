//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 24/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import SnapKit
import Domain
import Kingfisher

final class DetailViewController : UIViewController, ErrorPresenting {
    
    //    MARK: - Subviews
    let contentView: UIView = UIView()
    let scrollView: UIScrollView = UIScrollView()
    let thumbnail: UIImageView = UIImageView()
    let favoriteIndicator: UIImageView = UIImageView(image: #imageLiteral(resourceName: "favorite_white"))
    let titleLabel: UILabel = UILabel()
    let abstractLabel: UILabel = UILabel()
    let fullArticleButton: UIButton = UIButton()
    
    //    MARK: - Depedencies
    private var articleDto: ArticleDTO
    private let navigator: DetailNavigating
    
    
    //    MARK: - Public methods
    @objc private func didTapFullArticleButton(_ button: UIButton) {
        guard let url = articleDto.articlePageURL,
            UIApplication.shared.canOpenURL(url) else {
                presentErrorAlert(message: Strings.yourDeviceCannotOpenThisURL, title: Strings.errorTitle)
                return
        }
        UIApplication.shared.open(url)
    }
    
    @objc private func navigateBack() {
        navigator.toMain()
    }
    
    //    MARK: - Initializers
    
    init(articleDto: ArticleDTO, navigator: DetailNavigating) {
        self.articleDto = articleDto
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: UIViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureView()
        configureLayout()
    }
    
    //    MARK: - View configuration
    private func configureNavigationController() {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow_back_black"), style: .plain, target: self, action: #selector (navigateBack))
        barButton.tintColor = .demoRed
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func configureView() {
        self.title = Strings.articleDetails
        view.backgroundColor = .demoWhite
        addSubviews()
        configureLabels()
        configureImageViews()
        configureButton()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbnail)
        contentView.addSubview(favoriteIndicator)
        contentView.addSubview(titleLabel)
        contentView.addSubview(abstractLabel)
        contentView.addSubview(fullArticleButton)
    }
    
    private func configureLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleLabel.textColor = .demoRed
        titleLabel.textAlignment = .center
        titleLabel.text = articleDto.title
        
        abstractLabel.numberOfLines = 0
        abstractLabel.font = UIFont.systemFont(ofSize: 15)
        abstractLabel.text = articleDto.abstract
    }
    
    private func configureImageViews() {
        thumbnail.kf.setImage(with: articleDto.thumbnailURL)
        thumbnail.backgroundColor = .demoWhite
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        
        favoriteIndicator.contentMode = .scaleAspectFit
        favoriteIndicator.tintColor = .demoRed
        favoriteIndicator.layer.shadowColor = UIColor.demoWhite.cgColor
        favoriteIndicator.layer.shadowOpacity = 0.3
        favoriteIndicator.layer.shadowOffset = CGSize(width: 5, height: 5)
        favoriteIndicator.isHidden = !articleDto.isFavorite
        
    }
    
    private func configureButton() {
        fullArticleButton.setTitle(Strings.goToWikiPage, for: .normal)
        fullArticleButton.backgroundColor = .demoRed
        fullArticleButton.setTitleColor(.demoWhite, for: .normal)
        fullArticleButton.layer.shadowColor = UIColor.demoBlack.cgColor
        fullArticleButton.layer.shadowOpacity = 0.3
        fullArticleButton.layer.shadowOffset = CGSize(width: 5, height: 0)
        fullArticleButton.addTarget(self, action: #selector (didTapFullArticleButton(_:)), for: .touchUpInside)
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(view.snp.height).priority(.medium)
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(fullArticleButton).offset(LayoutConstants.doubledOffset)
        }
        let thumbnailHeight = articleDto.scaledHeight(forWidth: view.frame.width)
        thumbnail.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(thumbnailHeight)
        }
        favoriteIndicator.snp.makeConstraints { (make) in
            make.size.equalTo(LayoutConstants.buttonHeight)
            make.trailing.bottom.equalTo(thumbnail).inset(LayoutConstants.defaultOffset)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnail.snp.bottom).offset(LayoutConstants.defaultOffset)
            make.leading.equalTo(LayoutConstants.doubledOffset)
            make.trailing.equalTo(-LayoutConstants.doubledOffset)
        }
        abstractLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalTo(titleLabel)
        }
        fullArticleButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(abstractLabel.snp.bottom).offset(LayoutConstants.defaultOffset)
            make.height.equalTo(LayoutConstants.buttonHeight)
            make.trailing.equalTo(-LayoutConstants.doubledOffset)
            make.leading.equalTo(LayoutConstants.doubledOffset)
        }
    }
    
}
