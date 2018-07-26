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

    var provider: PatternListProvider = PatternListProviderImpl()

    override func loadView() {
        super.loadView()

        let tableView = UITableView(frame: .zero)
        let manager = TableViewManager.init(tableView: tableView)
    
        view.addSubview(tableView)
        tableView.snp.pinToSuperview()

        self.manager = manager
        self.tableView = tableView

        let button = UIBarButtonItem.init(barButtonSystemItem: .refresh,
                                          target: self,
                                          action: #selector(rightBarButtonAction(sender:)))

        navigationItem.rightBarButtonItem = button
    }

    @objc func rightBarButtonAction(sender: Any) {
        provider.fetchRemote()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        provider.delegate = self
        manager?.addData(provider.requestItems())
    }
}

extension ListOfPatternsVC: PatternListProviderDelegate {

    func failedToFetch() {
        //hmm
    }

    func didFetchRemotePatterns(data: [TableViewData]) {
        
        manager?.removeAllData()
        manager?.addData(provider.requestItems())
    }

}
