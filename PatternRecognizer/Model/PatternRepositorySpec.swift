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

            afterEach {
                MagicalRecord.cleanUp()
            }

            describe("Create new pattern") {

                var pattern: Pattern!

                beforeEach {
                    pattern = sut.createPattern(angles: [10, 11], name: "44", image: UIImage())
                }

                it("should have name 44") {
                    expect(pattern.name).to(equal("44"))
                }

                it("should correct angles") {
                    let angles = pattern.angles
                    expect(angles).to(equal([10, 11]))
                }


            }

            describe("Load all patters") {

                var patterns: [Pattern]!

                beforeEach {
                    _ = sut.createPattern(angles: [10, 11], name: "44", image: UIImage())
                    _ = sut.createPattern(angles: [10, 12], name: "45", image: UIImage())
                    patterns = sut.allPatternsSorted()
                }

                it("should have 2 patterns") {
                    expect(patterns.count).to(equal(2))
                }

            }

        }
    }
}

