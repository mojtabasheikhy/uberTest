//
//  uberApp.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI
import Firebase
class AppDelegate : NSObject , UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct uberApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var LocationViewModel = LocationSearchViewModel()
    @StateObject var authViewModel     = AuthViewModel()
    @StateObject var homeViewModel     = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(LocationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(homeViewModel)
           // LoginView()
        }
    }
}


