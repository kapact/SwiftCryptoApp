//
//  HapticManager.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 09/12/24.
//

import Foundation
import SwiftUI

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
