//
//  UnknowError.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public struct UnknownError : Error {
    public init() {}
    
    var localizedDescription: String {
        return "Error while parsing object"
    }
}
