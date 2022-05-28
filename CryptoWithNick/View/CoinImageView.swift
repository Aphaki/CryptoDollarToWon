//
//  CoinImageView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/24.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageVM
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageVM(coin: coin))
    }
    
    var body: some View {
        
        ZStack {
            if let image = vm.coinImg {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                ProgressView()
                    .scaledToFit()
            } else {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
