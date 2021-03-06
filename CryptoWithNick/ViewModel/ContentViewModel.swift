//
//  ContentViewModel.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/20.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    // 달러로 받을때
    @Published var coins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    // 공통 변수
    @Published var searchBarText: String = ""
    @Published var sortOption: SortOption = .holdings
    @Published var isLoading: Bool = false
    // 원화로 받을때
    @Published var krwCoins: [CoinModel] = []
    @Published var krwPortfolioCoins: [CoinModel] = []
    @Published var krwStatistics: [StatisticModel] = []
    
    private let exchangeRateService = ExchangeRateDataService()
    private let dataService = DataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    // 정렬 옵션
    enum SortOption {
        case rank, rankReversed, price, priceReversed, holdings, holdingsReversed
    }
    
    init() {
        subscribeService()
    }
    
    func reload() {
        isLoading = true
        dataService.fetchCoins()
        marketDataService.fetchData()
        HapticManager.notification(type: .success)
    }
    
    func subscribeService() {
        
        // 코인 업데이트, 검색어 필터링, 코인 정렬
        $searchBarText
            .combineLatest(dataService.$coins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }.store(in: &cancellable)
        
        // 포트폴리오 코인 업데이트
        $coins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(filteringPortfolioCoins)
            .sink { [weak self] filteredCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: filteredCoins)
            }
            .store(in: &cancellable)
        
        // 마켓데이터 업데이트
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mappingMarketData)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stats in
                guard let self = self else { return }
                self.statistics = stats
            }
            .store(in: &cancellable)
        
        // 한화로 변경
        $coins
            .combineLatest(exchangeRateService.$usdModel, $portfolioCoins)
            .map(mappingDollarToWon)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins, returnedPortCoins in
                self?.krwCoins = returnedCoins
                self?.krwPortfolioCoins = returnedPortCoins
            }
            .store(in: &cancellable)
        // 마켓데이터 원화로 업데이트
        marketDataService.$marketData
            .combineLatest($krwPortfolioCoins, exchangeRateService.$usdModel)
            .map(mappingMarketDataToWon)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] krwStats in
                self?.krwStatistics = krwStats
                self?.isLoading = false
            }.store(in: &cancellable)
    }
    func mappingMarketDataToWon(marketData: DataClass?, krwPortCoins: [CoinModel], usdModel: ExchangeRateModel?) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        
        guard
            let data = marketData,
            let unwrapedUSDModel = usdModel,
            let rate = Double(unwrapedUSDModel.dealBasR.removeingComma)
        else {
           return stats
        }
        
        let marketCapValue = (data.rawMarketCap * rate)
        let marketCapModel = StatisticModel(title: "시가총액", value: "₩" + marketCapValue.formattedWithAbbreviations(), percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumeModel = StatisticModel(title: "24H 거래량", value: data.volume)
        
        let btcDominanceModel = StatisticModel(title: "BTC 비율", value: data.btcDominance)
        
        let portfolioValue = krwPortCoins.map { coin in
            return coin.currentHoldingsValue
        }.reduce(0, +)
        let previousValue = krwPortCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }.reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        let krwPortModel = StatisticModel(title: "포트폴리오", value: portfolioValue.asWonCurrency(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
          marketCapModel,
          volumeModel,
          btcDominanceModel,
          krwPortModel
        ])
        return stats
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func mappingDollarToWon(allCoins: [CoinModel], usdModel: ExchangeRateModel?, portCoins: [CoinModel]) -> (krCoins: [CoinModel], krPortCoins: [CoinModel]) {
        guard
            let unwrapedUSDModel = usdModel,
            let rate = Double(unwrapedUSDModel.dealBasR.removeingComma)
        else {
           print("rate is nil")
           return (allCoins, portCoins) }
        let krCoins = allCoins.map { coin -> CoinModel in
            let krCurrentPrice = coin.currentPrice * rate
            let krMarketCap = (coin.marketCap ?? 0) * rate
            let krTotalVolume = (coin.totalVolume ?? 0) * rate
            let krHigh24 = (coin.high24H ?? 0) * rate
            let krLow24 = (coin.low24H ?? 0) * rate
            let krPriceChange24 = (coin.priceChange24H ?? 0) * rate
            let krMarketCapChange24H = (coin.marketCapChange24H ?? 0) * rate
            let krSparklineArray = coin.sparklineIn7D?.price?.map
            { aPrice -> Double in
              return aPrice * rate
            }
            let krSparklineIn7d = SparklineIn7D(price: krSparklineArray)
            return CoinModel(id: coin.id,
                             symbol: coin.symbol,
                             name: coin.name,
                             image: coin.image,
                             currentPrice: krCurrentPrice ,
                             marketCap: krMarketCap,
                             marketCapRank: coin.marketCapRank,
                             fullyDilutedValuation: coin.fullyDilutedValuation,
                             totalVolume: krTotalVolume,
                             high24H: krHigh24,
                             low24H: krLow24,
                             priceChange24H: krPriceChange24,
                             priceChangePercentage24H: coin.priceChangePercentage24H,
                             marketCapChange24H: krMarketCapChange24H,
                             marketCapChangePercentage24H: coin.marketCapChangePercentage24H,
                             circulatingSupply: coin.circulatingSupply,
                             totalSupply: coin.totalSupply,
                             maxSupply: coin.maxSupply,
                             ath: coin.ath,
                             athChangePercentage: coin.athChangePercentage,
                             athDate: coin.athDate,
                             atl: coin.atl,
                             atlChangePercentage: coin.atlChangePercentage,
                             atlDate: coin.atlDate,
                             lastUpdated: coin.lastUpdated,
                             sparklineIn7D: krSparklineIn7d,
                             priceChangePercentage24HInCurrency: coin.priceChangePercentage24HInCurrency,
                             currentHoldings: coin.currentHoldings)
        }
        let krPortCoins = portCoins.map { coin -> CoinModel in
            let krCurrentPrice = coin.currentPrice * rate
            let krMarketCap = (coin.marketCap ?? 0) * rate
            let krTotalVolume = (coin.totalVolume ?? 0) * rate
            let krHigh24 = (coin.high24H ?? 0) * rate
            let krLow24 = (coin.low24H ?? 0) * rate
            let krPriceChange24 = (coin.priceChange24H ?? 0) * rate
            let krMarketCapChange24H = (coin.marketCapChange24H ?? 0) * rate
            let krSparklineArray = coin.sparklineIn7D?.price?.map
            { aPrice -> Double in
              return aPrice * rate
            }
            let krSparklineIn7d = SparklineIn7D(price: krSparklineArray)
            return CoinModel(id: coin.id,
                             symbol: coin.symbol,
                             name: coin.name,
                             image: coin.image,
                             currentPrice: krCurrentPrice ,
                             marketCap: krMarketCap,
                             marketCapRank: coin.marketCapRank,
                             fullyDilutedValuation: coin.fullyDilutedValuation,
                             totalVolume: krTotalVolume,
                             high24H: krHigh24,
                             low24H: krLow24,
                             priceChange24H: krPriceChange24,
                             priceChangePercentage24H: coin.priceChangePercentage24H,
                             marketCapChange24H: krMarketCapChange24H,
                             marketCapChangePercentage24H: coin.marketCapChangePercentage24H,
                             circulatingSupply: coin.circulatingSupply,
                             totalSupply: coin.totalSupply,
                             maxSupply: coin.maxSupply,
                             ath: coin.ath,
                             athChangePercentage: coin.athChangePercentage,
                             athDate: coin.athDate,
                             atl: coin.atl,
                             atlChangePercentage: coin.atlChangePercentage,
                             atlDate: coin.atlDate,
                             lastUpdated: coin.lastUpdated,
                             sparklineIn7D: krSparklineIn7d,
                             priceChangePercentage24HInCurrency: coin.priceChangePercentage24HInCurrency,
                             currentHoldings: coin.currentHoldings)
        }
        return (krCoins, krPortCoins)
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
    
    private func mappingMarketData (marketData: DataClass?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap",
                                       value: "$" + data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map { coin in
            return coin.currentHoldingsValue
        }.reduce(0, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }.reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(title: "Portfolio", value: portfolioValue.asCurrencyWith2Demicals(), percentageChange: percentageChange)
        
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
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel])  {
        switch sort {
        case .rank , .holdings:
            coins.sort { $0.rank < $1.rank }
        case .rankReversed, .holdingsReversed:
            coins.sort { $0.rank > $1.rank }
        case .price:
            coins.sort { $0.currentPrice > $1.currentPrice }
        case .priceReversed:
            coins.sort { $0.currentPrice < $1.currentPrice }
        }
    }
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var filteredCoins = coinFiltering(text: text, startingCoins: coins)
        sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
    }
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted{ $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingsReversed:
            return coins.sorted{ $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
           return coins
        }
    }
}
