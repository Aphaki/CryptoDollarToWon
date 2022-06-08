//
//  DataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/20.
//

import Foundation
import Combine

class DataService {
    
    @Published var coins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else { return }
       coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] returnedCoins in
                self?.coins = returnedCoins
                self?.coinSubscription?.cancel()
            }
        
    }
    
}
