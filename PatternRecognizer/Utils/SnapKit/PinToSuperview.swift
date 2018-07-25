//
//  ConstraintViewDSL+SuperView.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import SnapKit

extension ConstraintViewDSL {

    func pinToSuperview() {
        makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
        }
    }

}
