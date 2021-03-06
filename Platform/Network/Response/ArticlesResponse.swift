//
//  ArticlesResponse.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Domain

internal struct ArticlesResponse : Decodable {
    let items: [Article]
}
