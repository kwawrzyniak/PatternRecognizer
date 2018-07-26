//
//  PatternRecognizerSpec.swift
//  PatternRecognizerTests
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable
import PatternRecognizer

class PatternRecognizerSpec: QuickSpec {
    override func spec() {

        describe("PatternRecognizer") {

            var sut: PatternRecognizer!
            var view: UIView!

            beforeEach {
                view = UIView.init()
                sut = PatternRecognizer(name: "44", modelAngles: [-Float.pi / 2, 0, Float.pi / 2])
                view.addGestureRecognizer(sut)

                let firstTouch = FakeTouch(point: CGPoint.init(x: 100, y: 100))
                let secondTouch = FakeTouch(point: CGPoint.init(x: 100, y: 50))
                let thridTouch = FakeTouch(point: CGPoint.init(x: 150, y: 50))
                let fourthTouch = FakeTouch(point: CGPoint.init(x: 150, y: 100))

                let beganSet: Set<UITouch> = [firstTouch]
                let movedSet: Set<UITouch> = [secondTouch]
                let movedSet2: Set<UITouch> = [thridTouch]
                let endedSet: Set<UITouch> = [fourthTouch]

                sut.touchesBegan(beganSet, with: UIEvent())
                sut.touchesMoved(movedSet, with: UIEvent())
                sut.touchesMoved(movedSet2, with: UIEvent())
                sut.touchesEnded(endedSet, with: UIEvent())
            }

            it("should have correct 44 name") {
                expect(sut.name).to(equal("44"))
            }

            it("should have recognized state") {
                expect(sut.state == .recognized).to(beTrue())
            }

            describe("Testing helpers method") {

                var angles: [Float]!


                beforeEach {
                    let p1 = CGPoint.init(x: 100, y: 100)
                    let p2 = CGPoint.init(x: 100, y: 50)
                    let p3 = CGPoint.init(x: 150, y: 50)
                    let p4 = CGPoint.init(x: 150, y: 100)

                    let points = [p1, p2, p3, p4]

                    angles = points.calculateAnglesBetweenPoints()
                }

                it("should have correct angles: -pi/2;0;pi/2") {
                    let first = angles[0]
                    let second = angles[1]
                    let third = angles[2]
                    expect(first).to(beCloseTo(-Float.pi / 2))
                    expect(second).to(beCloseTo(0))
                    expect(third).to(beCloseTo(Float.pi / 2))
                }

            }

        }
    }
}

