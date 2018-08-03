
//
//  ObservableType.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Domain

extension ObservableType {
    
    func mapObject<T : ImmutableMappable>(toType type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let json = data as? [String: Any],
                let object = try? Mapper<T>().map(JSON: json)
            else {
                throw ParseError.parseError
            }
            return Observable.just(object)
        }
    }
}
