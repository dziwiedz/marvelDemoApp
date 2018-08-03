//
//  ArticleDTO.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 24/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public class ArticleDTO {
    
    public let article: Article
    
    public var isExpanded: Bool = false
    public var isFavorite: Bool = false
    
    public var title: String {
        get { return article.title}
    }
    
    public var abstract: String {
        get { return article.abstract }
    }
    
    public var thumbnailURL: URL? {
        get { return URL(string: article.thumbnailUrl) }
    }
    
    public var articlePageURL: URL? {
        get { return ApiRouter.webPageUrl.appendingPathComponent(article.url)}
    }
    
    public init(article: Article) {
        self.article = article
    }
    
    public func scaledHeight(forWidth width: CGFloat) -> CGFloat {
        let aspectRatio = CGFloat(article.originalDimension.height) / CGFloat(article.originalDimension.width)
        return width * aspectRatio
    }
}
