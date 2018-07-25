//
//  TabContainerProvider.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit

protocol TabContainerProvider {

    func provideControllers() -> [UIViewController]

}

class TabContainerProviderImpl: TabContainerProvider {

    private func createRecognizerTab() -> UINavigationController {

        let recognizeTab = RecognizeTabVC()
        recognizeTab.title = "recognize.tab.title".localized

        let recognizeTabItem = UITabBarItem(title: "recognize.tab.title".localized,
                                            image: UIImage.init(named: "first"),
                                            tag: 0)

        recognizeTab.tabBarItem = recognizeTabItem

        let recognizerTabNC = UINavigationController(rootViewController: recognizeTab)

        return recognizerTabNC
    }

    private func createDrawTab() -> UINavigationController {

        let drawTab = SettingsTabVC()
        drawTab.title = "settings.tab.title".localized

        let drawTabItem = UITabBarItem(title: "settings.tab.title".localized,
                                       image: UIImage.init(named: "second"),
                                       tag: 1)
        drawTab.tabBarItem = drawTabItem
        let drawTabNC = UINavigationController(rootViewController: drawTab)
        return drawTabNC
    }

    func provideControllers() -> [UIViewController] {

        let recognizerTabNC = createRecognizerTab()
        let drawTabNC = createDrawTab()

        return [recognizerTabNC, drawTabNC]
    }

}
