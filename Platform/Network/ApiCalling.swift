//
//  ApiCalling.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

internal protocol ApiCalling {
    typealias Headers = [String: String]
    var session : SessionManager { get }
    var url : URL { get }
    var paramaters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var headers: Headers? { get }
    
    func makeRequest() -> Observable<Data>
}

extension ApiCalling {
    
    func makeRequest() -> Observable<Data> {
        return session.rx
            .data(method, url, parameters: paramaters, encoding: encoding, headers: headers)
    }
}


