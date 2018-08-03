//
//  OriginalDimension+Mappable.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

extension OriginalDimension: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OriginalDimensionCodingKeys.self)
        let width = try container.decode(Int.self, forKey: .width)
        let height = try container.decode(Int.self, forKey: .height)
        self.init(width: width , height: height)
    }
    
    private enum OriginalDimensionCodingKeys: String, CodingKey {
        case width
        case height
    }
}


