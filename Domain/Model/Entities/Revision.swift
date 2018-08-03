//
//  Revision.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public struct Revision {
    public let id: Int
    public let user: String
    public let userId: Int
    public let timestamp: Date
    
    public init(id: Int, user: String, userId: Int, timestamp: Date) {
        self.id = id
        self.user = user
        self.userId = userId
        self.timestamp = timestamp
    }
}
