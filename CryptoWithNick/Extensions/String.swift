//
//  String.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/07.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var removeingComma: String {
        return self.replacingOccurrences(of: ",", with: "")
    }
}
