//
//  CoinImageVM.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageVM: ObservableObject {
    // 매개변수로 (coin) 받아 안의 프로퍼티 (url) 주소로 네트워킹
    
    @Published var isLoading = false
    @Published var coinImg: UIImage? = nil
   
   private let coin: CoinModel
   private var cancellable = Set<AnyCancellable>()
   private let coinImgService: CoinImgDataService
    
   init(coin: CoinModel) {
       self.coin = coin
       self.coinImgService = CoinImgDataService(coin: coin)
       self.addSubscriber()
       self.isLoading = true
    }
   
    private func addSubscriber() {
        coinImgService.$coinImg
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] img in
                self?.coinImg = img
            }.store(in: &cancellable)
    }
}
