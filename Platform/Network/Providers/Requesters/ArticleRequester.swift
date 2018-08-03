//
//  ArticleRequester.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Alamofire
import Domain

final class ArticleRequster : ApiGetting {
    internal let session: SessionManager = SessionManager.default
    private let endpointPath = "Articles/Top?"
    var url: URL {
        return URL(string: endpointPath, relativeTo: Domain.ApiRouter.baseUrl)!
    }
    
    var paramaters: Parameters? {
        return ["expand" : 1 , "limit" : 75, "category" : "Characters"]
    }
    var headers: ApiCalling.Headers?
    
    var encoding: ParameterEncoding = URLEncoding.default
    
}
