//
//  HapticManager.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/02.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
