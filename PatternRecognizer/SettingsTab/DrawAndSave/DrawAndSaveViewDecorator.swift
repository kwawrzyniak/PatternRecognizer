//
//  DrawAndSaveViewDecorator.swoft
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

class DrawAndSaveViewDecorator {

    weak var vc: DrawAndSaveVC?

    init(vc: DrawAndSaveVC) {
        self.vc = vc
    }

    func decorate() {
        guard let vc = vc else {
            return
        }
        
        let drawingNameTextField = UITextField()
        let drawingView = DrawingView(frame: .zero)
        
        vc.view.addSubview(drawingView)
        vc.view.addSubview(drawingNameTextField)
        
        drawingView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(120)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        drawingNameTextField.borderStyle = .roundedRect
        drawingNameTextField.returnKeyType = .done
        drawingNameTextField.placeholder = "draw_and_save.name.textfield.placeholder".localized
        
        drawingNameTextField.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(76)
            maker.bottom.equalTo(drawingView.snp.top).offset(-10)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
        }
        vc.drawingNameTextField = drawingNameTextField
        vc.drawingView = drawingView
    }

}
