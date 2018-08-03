//
//  Article+Mappable.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

extension Article: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let abstract:String = try container.decode(String.self, forKey: .abstract)
        let thumbnailUrl:String = try container.decode(String.self, forKey: .thumbnailUrl)
        let title:String = try container.decode(String.self, forKey: .title)
        let url:String = try container.decode(String.self, forKey: .url)
        let revision: Revision = try container.decode(Revision.self, forKey: .revision)
        let type: String = try container.decode(String.self, forKey: .type)
        let originalDimension:OriginalDimension = try container.decode(OriginalDimension.self, forKey: .originalDimension)
        self = Article(id: id, title: title, url: url, type: type, abstract: abstract, thumbnailUrl: thumbnailUrl, revision: revision, originalDimension: originalDimension)
    }
    
    private enum ArticleCodingKeys: String, CodingKey {
        case id = "id"
        case abstract = "abstract"
        case thumbnailUrl = "thumbnail"
        case title = "title"
        case url = "url"
        case revision = "revision"
        case type = "type"
        case originalDimension = "original_dimensions"
    }
}
