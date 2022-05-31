//
//  CryptoWithNickApp.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

@main
struct CryptoWithNickApp: App {
    
    @StateObject private var vm = ContentViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                ContentView()
                    .environmentObject(vm)
            }
        }
    }
}
