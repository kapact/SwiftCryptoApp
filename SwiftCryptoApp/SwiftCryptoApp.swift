//
//  SwiftCryptoAppApp.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 06/12/24.
//

import SwiftUI

@main
struct SwiftCryptoApp: App {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(homeViewModel)
        }
    }
}
