//
//  DrawAndSaveVC.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import SnapKit

class DrawAndSaveVC: UIViewController {

    weak var drawingNameTextField: UITextField?
    weak var drawingView: DrawingView?

    override func loadView() {
        super.loadView()
        let decorator = DrawAndSaveViewDecorator(vc: self)
        decorator.decorate()
        drawingNameTextField?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
    }

}

extension DrawAndSaveVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
