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
    
   private let dataService = DataService()
   private var cancellable = Set<AnyCancellable>()
    
    init() {
        subscribeService()
    }
    
    func subscribeService() {
        
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
