//
//  DrawAndSaveRouter.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
class DrawAndRouterAction: RouterAction {
    func handle(route: DrawAndSaveRoute, from source: DrawAndSaveVC) { }
}

enum DrawAndSaveRouterActionFlow {

    case pop

    var action: DrawAndRouterAction {
        switch self {
        case .pop:
            return PopAction()
        }
    }

}

class PopAction: DrawAndRouterAction {

    override func handle(route: DrawAndSaveRoute, from source: DrawAndSaveVC) {
        source.navigationController?.popViewController(animated: true)
    }

}

typealias DrawAndSaveRoute = Route<DrawAndSaveRouterActionFlow, Any>

class DrawAndSaveRouter: Router {

    func perfrom(_ route: DrawAndSaveRoute, from source: DrawAndSaveVC) {
        let action = route.routeId.action
        action.handle(route: route, from: source)
    }

}
