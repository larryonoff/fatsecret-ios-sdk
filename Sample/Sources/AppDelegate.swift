//
//  AppDelegate.swift
//  FatSecretSampleApp
//
//  Created by Ilya Laryionau on 02/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import FatSecretSDK
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let fatSecretClient: FatSecretClient = {
        fatalError("setup `consumerKey` and `consumerSecret`")

        let client = FatSecretClient(
            consumerKey: "",
            consumerSecret: "")
        return client
    }()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

