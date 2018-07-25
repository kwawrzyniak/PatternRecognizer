//
//  SettingsItem.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import CommonQuail

class SettingsItem: GenericTableViewDataItem<SettingsTableViewCell>, TableViewCellDecorator {

    let itemTitle: String
    let flowAtClick: SettingsFlow
    init(title: String, flow: SettingsFlow) {
        self.itemTitle = title
        self.flowAtClick = flow
    }

    func decorate(cell: UITableViewCellLoadableProtocol) {

        guard let cell = cell as? SettingsTableViewCell else {
            return
        }

        cell.settingsTitleLabel.text = itemTitle

    }
}
