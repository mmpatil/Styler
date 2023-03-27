////
////  AppDelegate.swift
////
////
////  Created by Manali Patil on 3/18/23.
////
//
//import UIKit
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate{
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // this line is important
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        // In project directory storyboard looks like Main.storyboard,
//        // you should use only part before ".storyboard" as its name,
//        // so in this example name is "Main".
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//
//        // controller identifier sets up in storyboard utilities
//        // panel (on the right), it is called 'Storyboard ID'
//        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//
//        self.window?.rootViewController = viewController
//        self.window?.makeKeyAndVisible()
//        return true
//    }
//
//}
