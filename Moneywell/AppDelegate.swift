//
//  AppDelegate.swift
//  Moneywell
//
//  Created by Abram Situmorang on 09/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import UserNotifications
import Shared

internal enum Identifiers {
    internal static let viewAction = "VIEW_IDENTIFIER"
    internal static let newsCategory = "NEWS_CATEGORY"
    internal static let merchantSpendingCategory = "SPENDING_CATEGORY"
    internal static let yesAction = "YES_IDENTIFIER"
    internal static let noAction = "NO_IDENTIFIER"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .n500
        UITabBar.appearance().tintColor = .black
        
        let tabBar = UITabBarController()
        
        let homeNavCon = DefaultNavigationController(rootViewController: HomeViewController())
        homeNavCon.tabBarItem = UITabBarItem(title: "Home",
                                             image: UIImage(named: "home-deselected")?.withRenderingMode(.alwaysOriginal),
                                             selectedImage: UIImage(named: "home-selected")?.withRenderingMode(.alwaysOriginal))
        
        let goalsNavCon = DefaultNavigationController(rootViewController: GoalsViewController())
        goalsNavCon.tabBarItem = UITabBarItem(title: "Goals",
                                              image: UIImage(named: "goals-deselected")?.withRenderingMode(.alwaysOriginal),
                                              selectedImage: UIImage(named: "goals-selected")?.withRenderingMode(.alwaysOriginal))
        
        let spendingsNavCon = DefaultNavigationController(rootViewController: SpendingsViewController())
        spendingsNavCon.tabBarItem = UITabBarItem(title: "Spendings",
                                               image: UIImage(named: "spendings-deselected")?.withRenderingMode(.alwaysOriginal),
                                               selectedImage: UIImage(named: "spendings-selected")?.withRenderingMode(.alwaysOriginal))
        
        tabBar.viewControllers = [homeNavCon, goalsNavCon, spendingsNavCon]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        // Push Notifications
        registerForPushNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        
        
    }
}

// MARK: Push Notifications
extension AppDelegate {
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, error in
                print("Permission granted: \(granted)")
                guard granted else { return }
                
                // MARK: Add notif category
                self.configureNotifCategory()
                
                self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func configureNotifCategory() {
        let viewAction = UNNotificationAction(
            identifier: Identifiers.viewAction, title: "View",
            options: [.foreground])
        
        let newsCategory = UNNotificationCategory(
            identifier: Identifiers.newsCategory, actions: [viewAction],
            intentIdentifiers: [], options: [])
        
        let yesAction = UNNotificationAction(identifier: Identifiers.yesAction,
                                             title: "Yes, let’s record my spending!",
                                             options: [.foreground])
        
        let noAction = UNNotificationAction(identifier: Identifiers.noAction,
                                             title: "Nope, just passing by.",
                                             options: [.foreground])
        
        let merchantSpendingCategory = UNNotificationCategory(identifier: Identifiers.merchantSpendingCategory,
                                                              actions: [yesAction, noAction],
                                                              intentIdentifiers: [],
                                                              hiddenPreviewsBodyPlaceholder: "",
                                                              options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([newsCategory, merchantSpendingCategory])
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        (window?.rootViewController as? UITabBarController)?.selectedIndex = 0
        
        if response.actionIdentifier == Identifiers.yesAction {
            let recordVC = RecordTransactionViewController()
            recordVC.edgesForExtendedLayout = []
            let recordNavCon = UINavigationController(rootViewController: recordVC)
            window?.rootViewController?.present(recordNavCon, animated: true, completion: nil)
        }
        
        completionHandler()
    }
}
