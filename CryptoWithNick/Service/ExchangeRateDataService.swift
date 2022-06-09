//
//  ExchangeRateDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/09.
//

import Foundation
import Combine

class ExchangeRateDataService {
    
    @Published var usdExchangeRate: Double? = 1250.7
    @Published var exchangeRateModel: ExchangeRateModel? = nil
    
    var isEmpty: Bool = false
    
    var usdSubscription: AnyCancellable?
    
    var currentDate = Date()
    
    init() {
        fetchUSD()
    }
    
    private func fetchUSD() {
        print("First currentDate : \(currentDate.asCustomString())")
        guard let url = URL(string: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=HCBiZ4wSwjer7d3VzKzaZQgHTkeCTFs5&searchdate=\(currentDate.asCustomString())&data=AP01") else { return }
       usdSubscription = NetworkingManager.download(url: url)
            .decode(type: [ExchangeRateModel].self, decoder: JSONDecoder())
            .map {[weak self] exchanges -> ExchangeRateModel? in
                guard let self = self else { return nil}
                if exchanges.isEmpty {
                    self.isEmpty = true
                    self.currentDate = self.currentDate.addingTimeInterval(-24*60*60)
                    self.fetchUSD()
                } else {
                    self.exchangeRateModel = exchanges.first { $0.curUnit == "USD" }
                    print("USDRateModel: \(String(describing: self.exchangeRateModel))")
                    
                }
                return self.exchangeRateModel
            }
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] returnedModel in
                self?.usdExchangeRate = Double(returnedModel?.dealBasR ?? "1250.7")
                print("USDExchangeRate : \(String(describing: self?.usdExchangeRate))")
                self?.usdSubscription?.cancel()
            }
    }
}
