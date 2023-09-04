//
//  uberApp.swift
//  uber
//
//  Created by moji on 5/27/1402 AP.
//

import SwiftUI

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
