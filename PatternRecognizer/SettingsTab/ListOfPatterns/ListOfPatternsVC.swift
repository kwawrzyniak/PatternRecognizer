//
//  ListOfPatterns.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import CommonQuail

class ListOfPatternsVC: UIViewController {

    var manager: TableViewManager?
    weak var tableView: UITableView?

    let provider: PatternListProvider = PatternListProviderImpl()

    override func loadView() {
        super.loadView()

        let tableView = UITableView(frame: .zero)
        let manager = TableViewManager.init(tableView: tableView)
        manager.delegate = self

        view.addSubview(tableView)
        tableView.snp.pinToSuperview()

        self.manager = manager
        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        manager?.addData(provider.requestItems())
    }
}

extension ListOfPatternsVC: TableViewManagerDelegate {

    func pinDelegate(_ item: TableViewData) {

    }

    func didSelect(_ item: TableViewData) {

    }
}
