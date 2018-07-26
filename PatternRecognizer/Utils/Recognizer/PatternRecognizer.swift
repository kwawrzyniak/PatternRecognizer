//
//  PatternRecognizer.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
import Foundation

extension Collection where Iterator.Element == CGPoint {

    func calculateAnglesBetweenPoints() -> [Float] {

        guard count > 2 else {
            return []
        }

        var result = [Float]()

        let pointsCount = count - 2

        let allPoints = map { $0 }

        for index in 0...pointsCount {

            let firstPoint = allPoints[index]
            let secondPoint = allPoints[index + 1]

            let xDiff = secondPoint.x - firstPoint.x
            let yDiff = secondPoint.y - firstPoint.y

            let angle = atan2f(Float(yDiff), Float(xDiff));
            result.append(angle)
        }

        return result
    }

}

class PatternRecognizer: UIGestureRecognizer {

    private var points: [CGPoint]
    private let modelAngles: [Float]

    init(name: String, modelAngles: [Float]) {
        points = [CGPoint]()
        self.modelAngles = modelAngles
        super.init(target: nil, action: nil)
        self.name = name
    }

    override func reset() {
        super.reset()
        self.points.removeAll()
        self.state = .possible
    }

    private func readPoint(_ touches: Set<UITouch>) -> CGPoint? {
        guard touches.count >= 1 else {
            return nil
        }

        guard let view = view else {
            return nil
        }

        guard let point = touches.first?.location(in: view) else {
            return nil
        }

        return point
    }

    private func sample(points: [Float]) -> [Float] {
        var result = [Float]()

        let modelCount = modelAngles.count
        let pointsCount = points.count

        for i in 0...modelCount - 1 {
            let maybeIndex = ((pointsCount - 1) * i) / (modelCount - 1)
            let index = max(0, maybeIndex)
            result.append(points[index])
        }

        return result
    }

    private func distanceBetweenAngle(first: Float, second: Float) -> Float {
        var phi = fabs(first - second)
        let m2pi = Float.pi * 2
        let pi = Float.pi
        phi = fmodf(phi, m2pi)
        let distance = phi > pi ? (m2pi - pi) : phi
        return distance
    }

    private func distance(firstAngles: [Float], secondAngles: [Float]) -> Float {
        var distance: Float = 0
        let minCount = min(firstAngles.count, secondAngles.count) - 1

        for i in 0...minCount {
            let first = secondAngles[i]
            let second = firstAngles[i]
            distance += distanceBetweenAngle(first: first, second: second)
        }

        return fabsf(distance / Float(minCount));
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        guard let point = readPoint(touches) else {
            state = .failed
            return
        }

        points.append(point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        guard let point = readPoint(touches) else {
            state = .failed
            return
        }

        points.append(point)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)

        guard let point = readPoint(touches) else {
            state = .failed
            return
        }

        points.append(point)

        let angles = points.calculateAnglesBetweenPoints()

        guard angles.count > 0 else {
            state = .failed
            return
        }

        let sampled = sample(points: angles)
        let measuredDistance = distance(firstAngles: sampled, secondAngles: modelAngles)

        if measuredDistance < 0.75 {
            state = .recognized
        } else {
            state = .failed
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
    }

}
