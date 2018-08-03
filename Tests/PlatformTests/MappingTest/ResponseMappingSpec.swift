//
//  ArticleMappingSpec.swift
//  Domain
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Quick
import Nimble
import Domain
@testable import Platform

class ResponseMappingSpec: QuickSpec {
    let fileName = "ResponseSample"
    
    override func spec() {
        describe("Article mapping test") {
            let data = JsonObjectLoader<ArticlesResponse>.loadObjectData(fromJsonFileName: fileName)
            it("it should not throw error", closure: {
                expect{ try JSONDecoder().decode(ArticlesResponse.self, from: data) }.toNot(throwError())
            })
        }
    }
}
