//
//  PatternsProvider.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import CommonQuail

protocol PatternListProvider {

    func requestItems() -> [TableViewData]

}

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

class PatternListProviderImpl: PatternListProvider {

    let repo: PatternRepository = PatternRepositoryImpl()

    func requestItems() -> [TableViewData] {

        let items = repo.allPatternsSorted().map { (p) -> TableViewData? in
            guard let name = p.name else {
                return nil
            }
            return PatternItem(name: name)
        }.compactMap { $0 }

        return items
    }

}
