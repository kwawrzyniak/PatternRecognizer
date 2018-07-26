//
//  PatternItem.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import CommonQuail

class PatternItem: GenericTableViewDataItem<TextTableViewCell>, TableViewCellDecorator {
    
    let patternName: String
    
    init(name: String) {
        patternName = name
    }
    
    func decorate(cell: UITableViewCellLoadableProtocol) {
        guard let cell = cell as? TextTableViewCell else {
            return
        }
        
        cell.settingsTitleLabel.text = patternName
        cell.settingsTitleLabel.backgroundColor = UIColor.green
    }
}
