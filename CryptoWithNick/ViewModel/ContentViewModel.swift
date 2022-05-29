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
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1.1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: 4.2),
        StatisticModel(title: "Title", value: "Value", percentageChange: -2.7)
    ]
    
    
   private let dataService = DataService()
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
