//
//  Router.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation

import UIKit

protocol RouterAction {
    
    associatedtype DestinationViewController: UIViewController
    associatedtype RouterFlow
    associatedtype RouteContext

    func handle(route: Route<RouterFlow, RouteContext>, from source: DestinationViewController)
}

struct Route<T, C> {
    
    let routeId: T
    var context: C?
    
    init(_ routeId: T, context: C) {
        self.routeId = routeId
        self.context = context
    }
    
    init(_ routeId: T) {
        self.routeId = routeId
        self.context = nil
    }
    
}

typealias DefaultRoute<T> = Route<T, Any>

protocol Router {
    
    associatedtype DestinationViewController: UIViewController
    associatedtype RouterFlow
    associatedtype RouteContext
    
    func perfrom(_ route: Route<RouterFlow, RouteContext>, from source: DestinationViewController)
    
}
