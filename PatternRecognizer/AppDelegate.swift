//
//  AppDelegate.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 25/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootNavigationContainer: UINavigationController?
    var appContainer: TabContainer?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        MagicalRecord.setupAutoMigratingCoreDataStack()
        window = UIWindow(frame: UIScreen.main.bounds)
        let container = TabContainer()
        let rootNC = UINavigationController(rootViewController: container)
        rootNavigationContainer = rootNC
        appContainer = container
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        rootNC.setNavigationBarHidden(true, animated: false)
        return true
    }



}

