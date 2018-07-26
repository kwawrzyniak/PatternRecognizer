//
//  PatternsProvider.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import CommonQuail

protocol PatternListProviderDelegate: class {
    func didFetchRemotePatterns(data: [TableViewData])
    func failedToFetch()
}

protocol PatternListProvider {

    var delegate: PatternListProviderDelegate? { get set }

    func requestItems() -> [TableViewData]
    func fetchRemote()

}

class PatternListProviderImpl: PatternListProvider {

    weak var delegate: PatternListProviderDelegate?

    let repo: PatternRepository = PatternRepositoryImpl()
    let httpHandler = HTTPHandlerImpl(baseURL: "https://jestemnawakacjach.com/")

    func fetchRemote() {

        let request = FetchPatternsRequest()

        httpHandler.make(request: request) { [weak self] (result: FetchPatternsResponse?, error) in

            guard let result = result else {
                self?.delegate?.failedToFetch()
                return
            }

            let patterns = result.data.map({ (rp) -> Pattern? in
                let angles = rp.angles
                return self?.repo.createOrUpdatePattern(angles: angles, name: rp.name, id: rp.id)
            }).compactMap { $0 }.map({ (p) -> TableViewData? in
                guard let name = p.name else {
                    return nil
                }
                return PatternItem(name: name)
            }).compactMap { $0 }

            self?.repo.persist()
            
            self?.delegate?.didFetchRemotePatterns(data: patterns)
        }

    }

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
