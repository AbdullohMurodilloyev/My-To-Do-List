//
//  AppDelegate.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

       var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        window = UIWindow()
//        window?.rootViewController = FirstVC.init(nibName: "FirstVC", bundle: nil)
        window?.rootViewController = MainVC.init(nibName: "MainVC", bundle: nil)
        window?.makeKeyAndVisible()
        
        
        return true
    }

   


}

