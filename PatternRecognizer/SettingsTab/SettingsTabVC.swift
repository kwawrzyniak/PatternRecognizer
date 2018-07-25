//
//  SettingsTabVC.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import SnapKit
import CommonQuail

class SettingsTabVC: UIViewController {

    let provider = SettingsTabDataProviderImpl()
    var manager: TableViewManager?
    let router = SettingsRouter()

    weak var tableView: UITableView?

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
        manager?.addData(provider.requestItems())
        view.backgroundColor = UIColor.orange
    }

}

extension SettingsTabVC: TableViewManagerDelegate {

    func didSelect(_ item: TableViewData) {

        guard let item = item as? SettingsItem else {
            return
        }

        let route = SettingsRoute.init(item.flowAtClick)
        router.perfrom(route, from: self)
    }

    func pinDelegate(_ item: TableViewData) {

    }
}

