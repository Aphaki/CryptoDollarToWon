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
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] img in
                self?.coinImg = img
            }.store(in: &cancellable)
    }
}
