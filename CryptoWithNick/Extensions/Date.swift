//
//  Date.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/07.
//

import Foundation

extension Date {
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
    private var customDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter
    }
    func asCustomString() -> String {
        return customDateFormatter.string(from: self)
    }
}
