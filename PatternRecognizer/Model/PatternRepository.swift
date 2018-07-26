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

protocol PatternRepository {

    func allPatternsSorted() -> [Pattern]

    func createPattern(angles: [Float], name: String, image: UIImage) -> Pattern?

    func persist()
}

class PatternRepositoryImpl: PatternRepository {

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

    func createPattern(angles: [Float], name: String, image: UIImage) -> Pattern? {
        let anglesStrings = angles.map { "\($0);" }.reduce("") { $0 + $1 }

        let pattern = Pattern.mr_createEntity(in: ctx)

        let imageData = UIImageJPEGRepresentation(image, 0.7)

        pattern?.imageData = imageData
        pattern?.pattern = anglesStrings
        pattern?.name = name
        pattern?.id = UUID.init().uuidString

        return pattern
    }

}
