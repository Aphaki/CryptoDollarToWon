//
//  ExchangeRateModel.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/09.
//

import Foundation

// MARK: - ExchangeRateModel
struct ExchangeRateModel: Codable {
    let result: Int?
    let curUnit,tts: String?
    let dealBasR: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case curUnit = "cur_unit"
        case tts
        case dealBasR = "deal_bas_r"
    }
}


