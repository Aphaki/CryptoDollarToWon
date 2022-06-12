//
//  DetailView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/03.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    @Binding var isDollar: Bool
    var body: some View {
        if let unwrapedCoin = coin {
            DetailView(coin: unwrapedCoin, isDollar: isDollar)
        }
    }
}


struct DetailView: View {
    
    private var gridColumns: [GridItem]
    = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @StateObject private var vm: CoinDetailVM
    @State private var shortDescription: Bool = true
    private var isDollar: Bool
    init(coin: CoinModel, isDollar: Bool) {
        _vm = StateObject(wrappedValue: CoinDetailVM(coin: coin))
        self.isDollar = isDollar
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ChartView(coin: vm.coin)
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        overviewTitle
                        Divider()
                        coinDescriptionSection
                        overviewGrid
                            .padding(.leading, 10)
                        additionalDetailsTitle
                            .padding(.top, 20)
                        Divider()
                        additionalDetailsGrid
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 10)
            } // ScrollView
            .navigationTitle(vm.coin.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingItem
                }
            }
        }
    }
}
extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .padding(.leading, 20)
    }
    private var coinDescriptionSection: some View {
            ZStack {
                if let coinDescription = vm.coinDescriptions,
                   !coinDescription.isEmpty {
                    
                    VStack {
                        Text(coinDescription.removingHTMLOccurances)
                            .foregroundColor(Color.theme.themeSecondary)
                            .lineLimit(shortDescription ? 3 : .max)
                        HStack {
                            Button {
                                withAnimation(.easeInOut) {
                                    shortDescription.toggle()
                                }
                            } label: {
                                Text(shortDescription ? "더보기" : "줄이기")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 3)
                            }
                            .tint(.blue)
                            Spacer()
                        }
                    }.frame(maxWidth: .infinity,alignment: .leading)
                }
            }
        }
    private var overviewGrid: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 30, pinnedViews: []) {
            ForEach(isDollar ? vm.overviewStatistic : vm.korOverviewStatistic) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    private var additionalDetailsGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .leading,
                  spacing: 30,
                  pinnedViews: [])
        {
            ForEach(isDollar ? vm.additionalStatistic : vm.korAdditionalStatistic) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    private var additionalDetailsTitle: some View {
        Text("Additional Details")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .padding(.leading, 20)
    }
        private var trailingItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin, isDollar: true)
        }.environmentObject(ContentViewModel())
    }
}
