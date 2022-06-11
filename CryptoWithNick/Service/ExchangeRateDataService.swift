//
//  ExchangeRateDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/09.
//

import Foundation
import Combine

class ExchangeRateDataService {
    
    @Published var usdModel: ExchangeRateModel? = nil
    
    var usdSubscription: AnyCancellable?
    
    var currentDate = Date()
    
    init() {
        fetchUSD()
    }
    
    private func fetchUSD() {
        print(currentDate.asCustomString())
        guard let url = URL(string: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=HCBiZ4wSwjer7d3VzKzaZQgHTkeCTFs5&searchdate=\(currentDate.asCustomString())&data=AP01") else { return }
      usdSubscription = NetworkingManager.download(url: url)
            .decode(type: [ExchangeRateModel].self, decoder: JSONDecoder())
            .map { exchanges -> ExchangeRateModel? in
                if exchanges.isEmpty {
                    let yesterday = self.currentDate.addingTimeInterval(-24*60*60)
                    self.currentDate = yesterday
                    self.fetchUSD()
                    return nil
                }
                print("NOW: " + self.currentDate.asCustomString())
                let usdExchangeRate = exchanges.first { $0.curUnit == "USD" }
                return usdExchangeRate
            }
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] returnedModel in
                print("receivedValue : \(String(describing: returnedModel))")
                self?.usdModel = returnedModel
                self?.usdSubscription?.cancel()
            }
    }
}
