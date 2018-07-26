//
//  FetchPatternsRequest.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import Unbox

struct RemotePattern: Unboxable {

    let id: String
    let name: String
    let pattern: String

    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.pattern = try unboxer.unbox(key: "pattern")
    }

}

struct FetchPatternsResponse: Unboxable {

    let data: [RemotePattern]

    init(unboxer: Unboxer) throws {
        self.data = try unboxer.unbox(key: "data")
    }

}

class FetchPatternsRequest: HttpHandlerRequest {

    func endPoint() -> String {
        return "shapes.json"
    }

    func method() -> String {
        return "GET"
    }

    func parameters() -> Dictionary<String, Any>? {
        return nil
    }

    func headers() -> Dictionary<String, String> {
        return [:]
    }

}
