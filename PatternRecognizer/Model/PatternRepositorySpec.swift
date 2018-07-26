//
//  PatternRepositorySpec.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import Foundation
import Quick
import Nimble
import MagicalRecord

@testable
import PatternRecognizer

class PatternRepositorySpec: QuickSpec {
    override func spec() {

        describe("PatternRepository") {
            var sut: PatternRepository!

            beforeEach {
                MagicalRecord.setupCoreDataStackWithInMemoryStore()
                sut = PatternRepositoryImpl()
            }

            describe("Create new pattern") {

                var pattern: Pattern!

                beforeEach {
                    pattern = sut.createPattern(angles: [10, 11], name: "44", image: UIImage())
                }

                it("should have name") {
                    expect(pattern.name).to(equal("44"))
                }

            }

        }
    }
}

