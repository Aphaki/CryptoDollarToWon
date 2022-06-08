//
//  CoinDetailDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/03.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    let coin: CoinModel
    var coinDetailSubscription: AnyCancellable?
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.fetchDetailData()
    }
    
    func fetchDetailData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] detailData in
                guard let self = self else { return }
                self.coinDetails = detailData
                self.coinDetailSubscription?.cancel()
            }
        
    }
    
}
