//
//  Double.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/23.
//

import Foundation

extension Double {
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    func asCurrencyWith2Demicals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
