//
//  AppDelegate.swift
//  TestApp
//
//  Created by Dario Abete on 28/04/22.
//

import UIKit
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let monitor = NWPathMonitor()
    private let monitorQueqe = DispatchQueue(label: "Monitor")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if targetEnvironment(simulator)
        debugPrint("iOS Simulator seems to have a bug in detecting network connection properly, so you need a real device to test this feature xD")
    #else
        monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    if let currentVC = UIApplication.shared.windows.first?.rootViewController {
                        currentVC.showAlert(message: "Internet connection is not available")
                    }
                }
            }
        }
        
        monitor.start(queue: monitorQueqe)
    #endif
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

