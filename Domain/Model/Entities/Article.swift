//
//  Article.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public struct Article {
    public let id: Int
    public let title: String
    public let url: String
    public let type: String
    public let abstract: String
    public let thumbnailUrl: String
    public let revision: Revision
    public let originalDimension: OriginalDimension
    
    public init(id: Int, title: String, url: String, type: String, abstract:String, thumbnailUrl: String, revision: Revision, originalDimension: OriginalDimension) {
        self.id = id
        self.title = title
        self.url = url
        self.type = type
        self.abstract = abstract
        self.thumbnailUrl = thumbnailUrl
        self.revision = revision
        self.originalDimension = originalDimension
    }
}
