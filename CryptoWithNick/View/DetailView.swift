//
//  DetailView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/03.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        if let unwrapedCoin = coin {
            DetailView(coin: unwrapedCoin)
        }
    }
}
struct DetailView: View {
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailVM(coin: coin))
    }
    private var gridColumns: [GridItem]
    = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @StateObject var vm: CoinDetailVM
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                overviewTitle
                Divider()
                overviewGrid
                    .padding(.leading, 10)
                additionalDetailsTitle
                    .padding(.top, 20)
                Divider()
                additionalDetailsGrid
                    .padding(.leading, 10)
            }
        }
    }
}
extension DetailView {
    var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading, 20)
    }
    var overviewGrid: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 30, pinnedViews: []) {
            ForEach(vm.overviewStatistic) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    var additionalDetailsGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .leading,
                  spacing: 30,
                  pinnedViews: [])
        {
            ForEach(vm.additionalStatistic) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    var additionalDetailsTitle: some View {
        Text("Additional Details")
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading, 20)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
