//
//  MarketDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/29.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: DataClass? = nil
    
    var marketSubscription: AnyCancellable?
    
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
       marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalCryptoData.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] returnedData in
                self?.marketData = returnedData.data
                self?.marketSubscription?.cancel()
            }
    }
}
