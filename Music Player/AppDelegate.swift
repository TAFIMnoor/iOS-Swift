//
//  AppDelegate.swift
//  Music Player
//
//  Created by mohammad noor uddin on 13/6/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//      let appearance = UINavigationBarAppearance()
//      appearance.configureWithOpaqueBackground()
//      appearance.backgroundColor = UIColor(named: <#T##String#>)
//      appearance.titleTextAttributes = [
//        NSAttributedString.Key.foregroundColor: UIColor.systemGray2
//      ]
//      appearance.largeTitleTextAttributes = [
//        NSAttributedString.Key.foregroundColor: UIColor.systemGray2
//      ]
//      UINavigationBar.appearance().standardAppearance = appearance
//      UINavigationBar.appearance().compactAppearance = appearance
//      UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        UIFont.familyNames.forEach ( { name in
//            for font_name in UIFont.fontNames(forFamilyName: name) {
//                print ("In\(font_name)")
//            }
//        })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

