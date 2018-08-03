
//
//  ObservableType.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation
import RxSwift
import Domain

extension ObservableType {
    
    func mapObject<T : Decodable>(toType type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let data = data as? Data,
                let object = try? JSONDecoder().decode(T.self, from: data)
                else {
                    throw ParseError()
            }
            return Observable.just(object)
        }
    }
}
