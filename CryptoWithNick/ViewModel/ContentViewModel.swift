//
//  ContentViewModel.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/20.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var coins: [CoinModel] = []
    @Published var searchBarText: String = ""
    @Published var statistics: [StatisticModel] = []
    
    
   private let dataService = DataService()
   private let marketDataService = MarketDataService()
   private var cancellable = Set<AnyCancellable>()
    
    init() {
        subscribeService()
    }
    
    func subscribeService() {
        // 검색어, 코인리스트 컴바인
        $searchBarText
            .combineLatest(dataService.$coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(coinFiltering)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }.store(in: &cancellable)
        
        marketDataService.$marketData
            .map(mappingMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellable)
    }
    
    private func mappingMarketData (marketData: DataClass?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap",
                                       value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio", value: "$0.00", percentageChange: 0.00)
        
        stats.append(contentsOf: [
             marketCap,
             volume,
             btcDominance,
             portfolio
        ])
        return stats
        
    }
    
    private func coinFiltering(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return startingCoins
        }
        let lowercasedText = text.lowercased()
        let filteredCoins = startingCoins.filter { coin in
           return coin.id.lowercased().contains(lowercasedText) ||
           coin.symbol.lowercased().contains(lowercasedText) ||
           coin.name.lowercased().contains(lowercasedText)
        }
        return filteredCoins
    }
    
}
