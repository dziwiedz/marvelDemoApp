//
//  Revision+Mappable.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

extension Revision: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RevisionCodingKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let user: String = try container.decode(String.self, forKey: .user)
        let userId: Int = try container.decode(Int.self, forKey: .userId)
        let stringInterval: String = try container.decode(String.self, forKey: .timestamp)
        guard let timeInterval = Double(stringInterval)
            else { throw ParseError() }
        let timestamp = Date(timeIntervalSince1970: timeInterval)
        self = Revision(id: id, user: user, userId: userId, timestamp: timestamp)
    }
    
    private enum RevisionCodingKeys: String, CodingKey {
        case id
        case user
        case userId = "user_id"
        case timestamp
    }
}
