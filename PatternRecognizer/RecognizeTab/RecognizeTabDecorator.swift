//
//  RecognizeTabDecorator.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

protocol ViewControllerDecorator {

    associatedtype DecoratableVC: UIViewController

    var controllerToDecorate: DecoratableVC? { get }

    func decorate()
}

class RecognizeTabDecorator: ViewControllerDecorator {

    weak var controllerToDecorate: RecognizeTabVC?

    init(vc: RecognizeTabVC) {
        self.controllerToDecorate = vc
    }

    func decorate() {

        guard let vc = controllerToDecorate else {
            return
        }

        let label = UILabel(frame: .zero)
        let drawingView = DrawingView(frame: .zero)

        vc.view.addSubview(drawingView)
        vc.view.addSubview(label)

        drawingView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }

        label.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(76)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.height.equalTo(40)
        }

        label.textAlignment = .center
        label.text = "recognize.tab.regognized.label".localized

        vc.drawingView = drawingView
        vc.recognizedLabel = label
    }
}
