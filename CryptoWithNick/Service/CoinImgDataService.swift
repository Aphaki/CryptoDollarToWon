//
//  CoinImgDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImgDataService {
    
    @Published var coinImg: UIImage? = nil
    
    var subscribtion: AnyCancellable?
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.downloadCoinImg()
    }
    
    func downloadCoinImg() {
        guard let url = URL(string: coin.image) else { return }
        
        subscribtion = NetworkingManager.download(url: url)
            .tryMap{ data -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler) {[weak self] img in
                self?.coinImg = img
                self?.subscribtion?.cancel()
            }
    }
}
