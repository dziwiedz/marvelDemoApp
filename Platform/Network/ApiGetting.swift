//
//  ApiGetting.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Alamofire

internal protocol ApiGetting : ApiCalling {
    
}

extension ApiGetting {
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var method: HTTPMethod {
        return .get
    }
}
