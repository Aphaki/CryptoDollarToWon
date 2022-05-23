//
//  Color.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let themeBlue = Color("BlueColor")
    let themeRed = Color("RedColor")
    let themeGreen = Color("GreenColor")
    let themeSecondary = Color("SecondaryColor")
}
