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
    
    var router = DrawAndSaveRouter()
    var repo: PatternRepository = PatternRepositoryImpl()

    override func loadView() {
        super.loadView()
        let decorator = DrawAndSaveViewDecoratorImpl(vc: self)
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

        guard let text = textField.text, text.count > 0 else {
            return false
        }

        guard let angles = drawingView?.pathAngles(), angles.isEmpty == false else {
            return false
        }

        _ = repo.createOrUpdatePattern(angles: angles, name: text)
        repo.persist()
        textField.resignFirstResponder()
        let route = DrawAndSaveRoute.init(.pop)
        router.perfrom(route, from: self)
        return true
    }
}
