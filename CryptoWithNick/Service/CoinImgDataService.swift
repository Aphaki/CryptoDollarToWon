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
    
    private var subscribtion: AnyCancellable?
    private let fileManager = LocalFileManager.shared
    private let coin: CoinModel
    private let imageName: String
    private let folderName: String = "coin_images"
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImgFromFile(imgName: imageName, folderName: folderName) {
            coinImg = savedImage
            print("Coin Image is fetched from Local File")
        } else {
            downloadCoinImg()
            print("Coin Image is downloaded")
        }
    }
    
    private func downloadCoinImg() {
        guard let url = URL(string: coin.image) else { return }
        subscribtion = NetworkingManager.download(url: url)
            .tryMap{ data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManager.completionHandler) {[weak self] img in
                guard
                    let self = self,
                    let downloadedImg = img
                else { return }
                self.coinImg = img
                self.subscribtion?.cancel()
                self.fileManager.saveImage(image: downloadedImg, folderName: self.folderName, imgName: self.imageName)
            }
    }
}
