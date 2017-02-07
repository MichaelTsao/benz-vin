//
//  AppDelegate.swift
//  UsedCarVIN
//
//  Created by huiguan on 12/19/16.
//  Copyright © 2016 daimler. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds);

        window?.rootViewController  = self.getRootViewController()

        window?.makeKeyAndVisible()

        self.initComponent()
        self.setNavStyle()
        
        return true
    }

    //init Third Componets
    func initComponent() {
        HUD.initComponent()

        //UMeng
        MobClick.setLogEnabled(true)
        UMAnalyticsConfig.sharedInstance().appKey = "5860718782b6351de0001941"
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
    }

    func setNavStyle(){
        let bar = UINavigationBar.appearance()
        bar.barTintColor = UIColor.black
        bar.shadowImage = nil

        var attrs = [String : AnyObject]()
        attrs[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 18)
        attrs[NSForegroundColorAttributeName] = UIColor.white
        bar.titleTextAttributes = attrs
    }

    func getRootViewController() -> UIViewController {

        return SplashPageViewController()
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
}
extension AppDelegate:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let viewControllers = tabBarController.viewControllers else {
            return
        }

        if viewControllers.first!.isEqual(viewController) {
            print("VIN Controller")
            UMEventsManager.Events.tapVINTab.count()
        }else{
            print("Report Controller")
            UMEventsManager.Events.tapReportTab.count()
        }
    }
}
