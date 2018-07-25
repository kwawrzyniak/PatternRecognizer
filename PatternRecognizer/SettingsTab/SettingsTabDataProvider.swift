//
//  SettingsTabDataProvider.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import CommonQuail

protocol SettingsTabDataProvider {

    func requestItems() -> [TableViewData]

}

class SettingsTabDataProviderImpl: SettingsTabDataProvider {

    func requestItems() -> [TableViewData] {

        let addNewPattern = SettingsItem(title: "settings.draw_new".localized,
                                         flow: .drawNewPattern)
        
        let listExistings = SettingsItem(title: "settings.load".localized,
                                         flow: .viewSavedPatterns)

        return [addNewPattern, listExistings]

    }

}

