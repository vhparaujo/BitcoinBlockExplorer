//
//  TesteAPIApp.swift
//  TesteAPI
//
//  Created by Victor Hugo Pacheco Araujo on 10/05/23.
//

import SwiftUI
import GoogleMobileAds

@main
struct BitcoinBlockExplorerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var addManager = AddManager()
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var currencyViewModel = CurrencyViewModel()
    @StateObject var subscriptionStore = SubscriptionStore()
    @StateObject var lastBlockViewModel = LastBlockViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(addManager)
                .environmentObject(currencyViewModel)
                .environmentObject(subscriptionStore)
                .environmentObject(lastBlockViewModel)
                .environmentObject(networkMonitor)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
