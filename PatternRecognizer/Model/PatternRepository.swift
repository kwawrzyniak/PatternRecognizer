//
//  PatternRepository.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import MagicalRecord

protocol PatternRepository {

    func add(angles: [Float], name: String) -> Pattern?

}

class PatternRepositoryImpl: PatternRepository {

    let ctx: NSManagedObjectContext

    init(ctx: NSManagedObjectContext = .mr_default()) {
        self.ctx = ctx
    }

    func add(angles: [Float], name: String) -> Pattern? {
        let anglesStrings = angles.map { "\($0);" }.reduce("") { $0 + $1 }

        let pattern = Pattern.mr_createEntity(in: ctx)

        pattern?.pattern = anglesStrings
        pattern?.name = name
        pattern?.id = UUID.init().uuidString

        return pattern
    }

}
