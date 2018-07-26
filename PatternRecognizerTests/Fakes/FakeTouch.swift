//
//  FakeTouch.swift
//  PatternRecognizerTests
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

class FakeTouch: UITouch {

    let mocketPointInView: CGPoint

    init(point: CGPoint) {
        mocketPointInView = point
    }

    override func location(in view: UIView?) -> CGPoint {
        return mocketPointInView
    }
    
    
}
