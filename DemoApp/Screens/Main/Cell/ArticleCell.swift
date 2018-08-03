//
//  ArticleCell.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

protocol ArticleCellDelegate: class {
    func articleCell(_ cell: ArticleCell, didTriggerExpandArticle article: ArticleDTO?)
    func articleCell(_ cell: ArticleCell, didTriggerAddToFavoriteArticle article: ArticleDTO?)
}

final class ArticleCell : UITableViewCell {
    
    // MARK: -  Subviews
    
    let thumbnail: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let abstractLabel: UILabel = UILabel()
    let pressInfoLabel: UILabel = UILabel()
    let favoriteButton: UIButton = UIButton()
    
    
    //    MARK: - Dependencies
    
    var article: ArticleDTO?
    
    //    MARK: - Delegates
    
    weak var delegate: ArticleCellDelegate?
    
    //    MARK: - Public methods
    
    func configureCell(withArticle article: ArticleDTO, delegate: ArticleCellDelegate? = nil ) {
        self.delegate = delegate
        self.article = article
        self.titleLabel.text = article.title
        self.abstractLabel.text = article.abstract
        self.abstractLabel.numberOfLines = article.isExpanded ? 0 : 2
        self.thumbnail.kf.setImage(with: article.thumbnailURL)
        let favoriteImage = article.isFavorite ? #imageLiteral(resourceName: "favorite_white") : #imageLiteral(resourceName: "favorite_border")
        self.favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    @objc func expandCell() {
        delegate?.articleCell(self, didTriggerExpandArticle: self.article)
    }
    
    @objc func triggerAddToFavorite() {
        delegate?.articleCell(self, didTriggerAddToFavoriteArticle: self.article)
    }
    
    //    MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.demoWhite
        self.selectionStyle = .none
        configureCell()
        configureLayout()
        configureLongGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - UITableViewCell life-cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        titleLabel.text = nil
        abstractLabel.text = nil
        delegate = nil
        article = nil
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite_border"), for: .normal)
    }

    //    MARK: - Private methods
    
    private func configureCell() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(titleLabel)
        contentView.addSubview(abstractLabel)
        contentView.addSubview(pressInfoLabel)
        contentView.addSubview(favoriteButton)
        
        thumbnail.image = nil
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .demoRed
        
        pressInfoLabel.text = Strings.holdToExpand
        pressInfoLabel.font = UIFont.italicSystemFont(ofSize: UIFont.smallSystemFontSize)
        
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite_border"), for: .normal)
        favoriteButton.setTitle(Strings.addToFavorite, for: .normal)
        favoriteButton.setTitleColor(.demoBlack, for: .normal)
        favoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.addTarget(self, action: #selector (triggerAddToFavorite), for: .touchUpInside)
        favoriteButton.tintColor = .demoRed
    }
    
    private func configureLayout() {
        thumbnail.snp.makeConstraints { (make) in
            make.height.equalTo(LayoutConstants.thumbnailHeight)
            make.leading.top.equalToSuperview().offset(LayoutConstants.doubledOffset)
            make.trailing.equalToSuperview().inset(LayoutConstants.doubledOffset)
            
        }
        titleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(favoriteButton.snp.leading).offset(LayoutConstants.defaultOffset)
            make.leading.equalTo(thumbnail)
            make.top.equalTo(thumbnail.snp.bottom).offset(LayoutConstants.defaultOffset)
        }
        
        abstractLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(LayoutConstants.defaultOffset)
            make.leading.equalTo(LayoutConstants.doubledOffset)
            make.trailing.equalTo(-LayoutConstants.doubledOffset)
            make.bottom.lessThanOrEqualToSuperview().inset(LayoutConstants.doubledOffset)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.height.equalTo(LayoutConstants.buttonHeight)
            make.width.equalTo(LayoutConstants.favoriteButtonWidth)
            make.trailing.equalTo(thumbnail)
            make.centerY.equalTo(titleLabel)
        }
        
        pressInfoLabel.snp.makeConstraints { (make) in
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    private func configureLongGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector (expandCell))
        gesture.minimumPressDuration = 1.0
        self.addGestureRecognizer(gesture)
    }
}
