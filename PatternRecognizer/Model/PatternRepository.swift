//
//  PatternRepository.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import MagicalRecord

extension Pattern {

    var angles: [Float] {

        guard let pattern = pattern else {
            return []
        }

        let angles = pattern.components(separatedBy: ";").map({ Float($0) }).compactMap { $0 }

        return angles
    }

}

extension RemotePattern {

    var angles: [Float] {

        let angles = pattern.components(separatedBy: ";").map({ Float($0) }).compactMap { $0 }
        return angles

    }
}

protocol PatternRepository {

    func allPatternsSorted() -> [Pattern]

    func createOrUpdatePattern(angles: [Float], name: String, id: String) -> Pattern?

    func persist()
}

extension PatternRepository {

    func createOrUpdatePattern(angles: [Float], name: String) -> Pattern? {
        return self.createOrUpdatePattern(angles: angles, name: name, id: UUID.init().uuidString)
    }

}


class PatternRepositoryImpl: PatternRepository {

    func createOrUpdatePattern(angles: [Float], name: String, id: String) -> Pattern? {

        let anglesStrings = angles.map { "\($0);" }.reduce("") { $0 + $1 }

        let pattern = Pattern.mr_findFirstOrCreate(byAttribute: "id", withValue: id, in: ctx)
        
        pattern.pattern = anglesStrings
        pattern.name = name
        pattern.id = id

        return pattern
    }


    let ctx: NSManagedObjectContext

    init(ctx: NSManagedObjectContext = .mr_default()) {
        self.ctx = ctx
    }

    func allPatternsSorted() -> [Pattern] {
        let patterns = Pattern.mr_findAllSorted(by: "name", ascending: true, in: ctx) as? [Pattern]
        return patterns ?? []
    }

    func persist() {
        ctx.mr_saveToPersistentStoreAndWait()
    }

}
