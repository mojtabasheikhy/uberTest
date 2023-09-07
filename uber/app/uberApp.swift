//
//  uberApp.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI
import Firebase

@main
struct uberApp: App {
    @StateObject var LocationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            //HomeView().environmentObject(LocationViewModel)
            LoginView()
        }
    }
}

class AppDelegate : NSObject , UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
