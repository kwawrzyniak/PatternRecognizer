//
//  RecognizeTabVC.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

class RecognizeTabVC: UIViewController {

    weak var recognizedLabel: UILabel?
    weak var drawingView: DrawingView?

    let repo: PatternRepository = PatternRepositoryImpl()

    var clearTimer: Timer?

    override func loadView() {
        super.loadView()
        let decorator = RecognizeTabDecorator(vc: self)
        decorator.decorate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupRecognizers()
    }
    
    func setupRecognizers() {

        let allPatterns = repo.allPatternsSorted()
        let recognizers = allPatterns.map { (p) -> PatternRecognizer? in

            let angles = p.angles

            guard let name = p.name, angles.count > 0 else {
                return nil
            }

            return PatternRecognizer(name: name, modelAngles: angles)
        }.compactMap { $0 }

        view.gestureRecognizers?.removeAll()

        recognizers.forEach { (recognizer) in
            recognizer.addTarget(self, action: #selector(didFoundPatternWith(sender:)))
            view.addGestureRecognizer(recognizer)
        }
    }

    @objc func didFoundPatternWith(sender: UIGestureRecognizer) {
        let shapeName = sender.name ?? ""

        let text = "\("recognize.tab.regognized.label".localized) \(shapeName)"
        recognizedLabel?.text = text
        clearTimer?.invalidate()

        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self](t) in

            guard let `self` = self else {
                return
            }

            t.invalidate()

            let text = "\("recognize.tab.regognized.label".localized) -"
            self.recognizedLabel?.text = text
            self.drawingView?.clear()

        }

        clearTimer = timer
    }
}

