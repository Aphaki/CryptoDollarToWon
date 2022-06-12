//
//  CoinDetailVM.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/03.
//

import Foundation
import Combine

class CoinDetailVM: ObservableObject {
    
    @Published var overviewStatistic: [StatisticModel] = []
    @Published var additionalStatistic: [StatisticModel] = []
    @Published var korOverviewStatistic: [StatisticModel] = []
    @Published var korAdditionalStatistic: [StatisticModel] = []
    @Published var coinDescriptions: String? = nil
    @Published var coin: CoinModel
    
    var subscription = Set<AnyCancellable>()
    
   private let detailDataService: CoinDetailDataService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.detailDataService = CoinDetailDataService(coin: coin)
        self.subscribeDetailData()
    }
    
    private func subscribeDetailData() {
        detailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (overview, additional) in
                self?.overviewStatistic = overview
                self?.additionalStatistic = additional
            }
            .store(in: &subscription)
        detailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToKorStatistics)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (overview, additional) in
                self?.korOverviewStatistic = overview
                self?.korAdditionalStatistic = additional
            }
            .store(in: &subscription)
        detailDataService.$coinDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedDetails in
                self?.coinDescriptions = returnedDetails?.description?.en?.removingHTMLOccurances
            }
            .store(in: &subscription)
    }
    
    // Dollar형 Statistics 만들기 (overview, additional + 변환)
    private func createOverviewStatistics(coin: CoinModel) -> [StatisticModel] {
        let price = coin.currentPrice.asCurrencyWith2Demicals()
        let priceChangePercentage = coin.priceChangePercentage24H
        let currentPriceStat = StatisticModel(title: "현재가", value: price, percentageChange: priceChangePercentage)
        
        let marketCapValue = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "시가총액", value: marketCapValue, percentageChange: marketCapChangePercentage)
        
        let rank = coin.rank
        let rankStat = StatisticModel(title: "랭크", value: "\(rank)")
        
        let volumeValue = coin.totalVolume?.formattedWithAbbreviations() ?? "?"
        let volumeStat = StatisticModel(title: "거래량", value: "$" + volumeValue)
        
        let overviewArray: [StatisticModel] = [
            currentPriceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        return overviewArray
    }
    private func createAdditionalStatistics(detailData: CoinDetailModel? ,coin: CoinModel) -> [StatisticModel] {
        let priceHighValue = coin.high24H?.asCurrencyWith2Demicals() ?? "n/a"
        let priceHigh24hStat = StatisticModel(title: "24h 최고가", value: priceHighValue)
        
        let priceLowValue = coin.low24H?.asCurrencyWith2Demicals() ?? "n/a"
        let priceLow24hStat = StatisticModel(title: "24h 최저가", value: priceLowValue )
        
        let priceChange24hValue = coin.priceChange24H?.asCurrencyWith2Demicals() ?? "n/a"
        let priceChange24hPer = coin.priceChangePercentage24HInCurrency ?? 0
        let priceChange24hStat = StatisticModel(title: "24h 변동성", value:  priceChange24hValue, percentageChange: priceChange24hPer)
        
        let marketCap24hChangeValue = coin.marketCap?.formattedWithAbbreviations() ?? "n/a"
        let marketCap24hChangePer = coin.marketCapChangePercentage24H ?? 0
        let marketCapChangeStat = StatisticModel(title: "24h 시총 변동성", value: "$" + marketCap24hChangeValue, percentageChange: marketCap24hChangePer)
        
        let blockTimeValue = detailData?.blockTimeInMinutes ?? 0
        let blockTimeStat = StatisticModel(title: "블록타임", value: "\(blockTimeValue)")
        
        let hashingAlogorithumValue = detailData?.hashingAlgorithm ?? "n/a"
        let hashingAlogorithumStat = StatisticModel(title: "해시 알고리즘", value: hashingAlogorithumValue)
        
        let additionalArray: [StatisticModel]
        = [
        priceHigh24hStat,
        priceLow24hStat,
        priceChange24hStat,
        marketCapChangeStat,
        blockTimeStat,
        hashingAlogorithumStat
        ]
        return additionalArray
    }
    private func mapDataToStatistics(detailData: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewStatistics = createOverviewStatistics(coin: coin)
        let additionalStatistics = createAdditionalStatistics(detailData: detailData, coin: coin)
        
        return (overviewStatistics, additionalStatistics)
    }
    
    // Won형 Statistics 만들기 (overview, additional + 변환)
    private func createWonOverviewStatistics(coin: CoinModel) -> [StatisticModel] {
        let price = coin.currentPrice.asWonCurrency()
        let priceChangePercentage = coin.priceChangePercentage24H
        let currentPriceStat = StatisticModel(title: "현재가", value: price, percentageChange: priceChangePercentage)
        
        let marketCapValue = "₩" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "시가총액", value: marketCapValue, percentageChange: marketCapChangePercentage)
        
        let rank = coin.rank
        let rankStat = StatisticModel(title: "랭크", value: "\(rank)")
        
        let volumeValue = coin.totalVolume?.formattedWithAbbreviations() ?? "?"
        let volumeStat = StatisticModel(title: "거래량", value: volumeValue)
        
        let overviewArray: [StatisticModel] = [
            currentPriceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        return overviewArray
    }
    private func createWonAdditionalStatistics(detailData: CoinDetailModel? ,coin: CoinModel) -> [StatisticModel] {
    
        let priceHighValue = coin.high24H?.asWonCurrency() ?? "n/a"
        let priceHigh24hStat = StatisticModel(title: "24h 최고가", value: priceHighValue)
        
        let priceLowValue = coin.low24H?.asWonCurrency() ?? "n/a"
        let priceLow24hStat = StatisticModel(title: "24h 최저가", value: priceLowValue )
        
        let priceChange24hValue = coin.priceChange24H?.asWonCurrency() ?? "n/a"
        let priceChange24hPer = coin.priceChangePercentage24HInCurrency ?? 0
        let priceChange24hStat = StatisticModel(title: "24h 변동성", value:  priceChange24hValue, percentageChange: priceChange24hPer)
        
        let marketCap24hChangeValue = coin.marketCap?.formattedWithAbbreviations() ?? "n/a"
        let marketCap24hChangePer = coin.marketCapChangePercentage24H ?? 0
        let marketCapChangeStat = StatisticModel(title: "24h 시총 변동성", value: "₩" + marketCap24hChangeValue, percentageChange: marketCap24hChangePer)
        
        let blockTimeValue = detailData?.blockTimeInMinutes ?? 0
        let blockTimeStat = StatisticModel(title: "블록타임", value: "\(blockTimeValue)")
        
        let hashingAlogorithumValue = detailData?.hashingAlgorithm ?? "n/a"
        let hashingAlogorithumStat = StatisticModel(title: "해시 알고리즘", value: hashingAlogorithumValue)
        
        let additionalArray: [StatisticModel]
        = [
        priceHigh24hStat,
        priceLow24hStat,
        priceChange24hStat,
        marketCapChangeStat,
        blockTimeStat,
        hashingAlogorithumStat
        ]
        return additionalArray
    }
    private func mapDataToKorStatistics(detailData: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewStatistics = createWonOverviewStatistics(coin: coin)
        let additionalStatistics = createWonAdditionalStatistics(detailData: detailData, coin: coin)
        
        return (overviewStatistics, additionalStatistics)
    }
}


