//
//  CoinRowView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/20.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let isFortfolio: Bool
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        HStack(spacing: 0){
                leftColumn
                Spacer()
            if isFortfolio{
                centerColumn
                    .animation(.none, value: isFortfolio)
            }
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
        Group {
            CoinRowView(coin: dev.coin, isFortfolio: true)
                .padding()
            .previewLayout(.sizeThatFits)
            .environmentObject(ContentViewModel())
            CoinRowView(coin: dev.krwCoin, isFortfolio: true)
                .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(ContentViewModel())
        }
    }
}

extension CoinRowView {
    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank )")
                .font(.caption)
                .foregroundColor(Color.theme.themeSecondary)
                .frame(width: 25)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
                .padding(.horizontal, 5)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
}
extension CoinRowView {
    // 센터 칼럼 : 갯수 * 현재가격 , 갯수
    var centerColumn: some View {
        VStack(alignment: .trailing) {
            if coin.currentHoldings != nil {
                Text( vm.isDollar ? ((coin.currentHoldings!) * (coin.currentPrice)).asCurrencyWith2Demicals()
                      : ((coin.currentHoldings!) * (coin.currentPrice)).asWonCurrency()
                )

                Text(coin.currentHoldings!.asNumberString())
            } else {
                Text("")
            }

        }.font(.caption)
            .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
    }
}
extension CoinRowView {
    var rightColumn: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Text(vm.isDollar ? coin.currentPrice.asCurrencyWith2Demicals()
                     : coin.currentPrice.asWonCurrency()
                )
            } // 현재 가격
            Text( (coin.priceChangePercentage24H ?? 0).asPercentString() )
                .foregroundColor( coin.priceChangePercentage24H ?? 0 >= 0 ? Color.green : Color.red )
        }
        .font(.caption)
        .frame(width: UIScreen.main.bounds.width / 4)
    }
}
