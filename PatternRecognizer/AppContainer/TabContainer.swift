//
//  AppContainer.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit


class TabContainer: UITabBarController {

    let dataProvider = TabContainerProviderImpl()

    override func loadView() {
        super.loadView()
        viewControllers = dataProvider.provideControllers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
