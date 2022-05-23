//
//  CoinRowView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/20.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
            HStack(spacing: 0){
                leftColumn
                Spacer()
                centerColumn
                rightColumn
            }
            .font(.subheadline)
            .background(
                Color.theme.background.opacity(0.001)
            )
    }
}

struct CoinRowView_Previews: PreviewProvider {    
    static var previews: some View {
        CoinRowView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank )")
                .font(.caption)
            .foregroundColor(Color.theme.themeSecondary)
            Circle()
                .frame(width: 30, height: 30)
                .padding(.horizontal, 5)
            Text(coin.symbol.uppercased())
        }
        
    }
}
extension CoinRowView {
    var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text( ((Double(5)) * (coin.currentPrice )).asCurrencyWith2Demicals() ) // 갯수 * 가격
            Text("\(5)") // 갯수
        }.font(.caption)
        .padding(.horizontal)
    }
}
extension CoinRowView {
    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text( ((coin.currentPrice) ).asCurrencyWith2Demicals() ) // 현재 가격
            Text( (coin.priceChangePercentage24H ?? 0).asPercentString() )
        }
        .font(.caption)
    }
}
