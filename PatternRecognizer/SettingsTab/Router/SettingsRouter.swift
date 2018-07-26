//
//  SettingsRouter.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation

class SettingsRouterAction: RouterAction {
    func handle(route: SettingsRoute, from source: SettingsTabVC) { }
}

enum SettingsFlow {

    case drawNewPattern
    case viewSavedPatterns

    var action: SettingsRouterAction {
        switch self {
        case .drawNewPattern:
            return DrawAction()
        case .viewSavedPatterns:
            return ViewSavedPatters()
        }
    }

}

class ViewSavedPatters: SettingsRouterAction {
    override func handle(route: SettingsRoute, from source: SettingsTabVC) {
        let list = ListOfPatternsVC()
        source.navigationController?.pushViewController(list, animated: true)
    }
}

class DrawAction: SettingsRouterAction {

    override func handle(route: SettingsRoute, from source: SettingsTabVC) {
        let drawAndSave = DrawAndSaveVC()
        source.navigationController?.pushViewController(drawAndSave, animated: true)
    }

}

typealias SettingsRoute = Route<SettingsFlow, Any>

class SettingsRouter: Router {

    func perfrom(_ route: SettingsRoute, from source: SettingsTabVC) {
        let action = route.routeId.action
        action.handle(route: route, from: source)
    }

}
