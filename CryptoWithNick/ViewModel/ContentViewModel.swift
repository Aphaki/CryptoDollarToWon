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
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchBarText: String = ""
    @Published var statistics: [StatisticModel] = []
    
    
   private let dataService = DataService()
   private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
   private var cancellable = Set<AnyCancellable>()
    
    init() {
        subscribeService()
    }
    
    func subscribeService() {
        // 코인 업데이트
        $searchBarText
            .combineLatest(dataService.$coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(coinFiltering)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }.store(in: &cancellable)
        // 마켓데이터 업데이트
        marketDataService.$marketData
            .map(mappingMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellable)
        // 포트폴리오 코인 업데이트
        $coins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(filteringPortfolioCoins)
            .sink { [weak self] filteredCoins in
                self?.portfolioCoins = filteredCoins
            }
            .store(in: &cancellable)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filteringPortfolioCoins(coinModels: [CoinModel], portfolioEntitys: [PortfolioEntity]) -> [CoinModel] {
        coinModels
            .compactMap { coin -> CoinModel? in
                guard
                    let entity = portfolioEntitys.first(where: { $0.coinID == coin.id })
                    else { return nil }
                return coin.updateHoldings(amount: entity.amount)
             }
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
