//
//  CryptoWithNickApp.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

@main
struct CryptoWithNickApp: App {
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                ContentView()
            }
        }
    }
}
