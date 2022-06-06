//
//  ChartView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/06.
//

import SwiftUI

struct ChartView: View {
    
    private var coin: CoinModel
    private let priceArray: [Double]
    private let maxY: Double
    private let minY: Double
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.priceArray = coin.sparklineIn7D?.price ?? []
        self.maxY = priceArray.max() ?? 0
        self.minY = priceArray.min() ?? 0
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
