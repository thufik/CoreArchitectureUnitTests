//
//  AppDelegate.swift
//  UnitTestWithArchitectureCore
//
//  Created by EquipeSuporteAplicacao on 5/23/18.
//  Copyright © 2018 Thufik. All rights reserved.
//


import CoreArchitecture
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    #if TESTE
    let x = 10
    #else
    let x = 11
    #endif

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(launchOptions)

        #if TESTE
            if let loginViewController = window?.rootViewController as? LoginViewController{
                let component = FakeLoginComponent(state: LoginState(isLoading: false, hasError: nil, isSuccessfull: nil))
                loginViewController.component = component
            }
        #else
            if let loginViewController = window?.rootViewController as? LoginViewController{
                let component = LoginComponent(state: LoginState(isLoading: false, hasError: nil, isSuccessfull: nil))
                loginViewController.component = component
            }
        #endif

        
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


}


class FakeLoginComponent: Component<LoginState> {
    
    override func process(_ action: Action) {
        
        guard let action = action as? LoginAction else{
            return
        }
        
        switch action {
        case .login(email: let mail, pass: let pass) : self.loginSuccessfull(email: mail, pass: pass)
        }
    }
    
    func loginSuccessfull(email : String, pass : String){
        var state = self.state
        state.isSuccessfull = ["Sucesso" : "Ok"]
        
        self.commit(state)
    }
}


