//
//  UIApplication.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/26.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
