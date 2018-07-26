//
//  DrawingView.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    var capturedPoints: [CGPoint] = [CGPoint]()

    func clear() {
        capturedPoints.removeAll()
        setNeedsDisplay()
    }

    func pathAngles() -> [Float] {
        return capturedPoints.calculateAnglesBetweenPoints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        capturedPoints.removeAll()

        guard let point = touches.first?.location(in: self) else {
            return
        }

        capturedPoints.append(point)
        setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        guard let point = touches.first?.location(in: self) else {
            return
        }

        capturedPoints.append(point)
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let point = touches.first?.location(in: self) else {
            return
        }

        capturedPoints.append(point)
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        ctx.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        ctx.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        ctx.fill(rect)
        ctx.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)

        capturedPoints.enumerated().forEach { (index, element) in
            if index == 0 {
                ctx.move(to: element)
            } else {
                ctx.addLine(to: element)
            }
        }

        ctx.strokePath()
    }


}
