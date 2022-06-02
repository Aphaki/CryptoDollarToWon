//
//  ContentView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

struct ContentView: View {
    @State var showFortfolio = false
    @State var showFortfolioView = false
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        VStack {
            headerView
            HomeStatsView(showPortfolio: $showFortfolio)
                .padding()
            SearchBarView(searchBarText: $vm.searchBarText)
                .padding(.horizontal, 10)
            columnTitles
            if !showFortfolio {
                allCoinLists
                .transition(.move(edge: .leading))
            } else {
                ZStack(alignment: .top) {
                    fortfolioLists
                        .transition(.move(edge: .trailing))
                }
            }
        }.sheet(isPresented: $showFortfolioView) {
            PortfolioView()
                .environmentObject(vm)
        }
    }
}
extension ContentView {
    var headerView: some View {
        HStack {
            ButtonView(iconName: !showFortfolio ? "info" : "plus")
                .animation(.none, value: showFortfolio)
                .onTapGesture {
                    if showFortfolio {
                        showFortfolioView.toggle()
                    }
                }
                .background(
                CircleButtonAnymationView(animate: $showFortfolio)
                )
            Spacer()
            Text(!showFortfolio ? "Live Prices" : "Fortfolio")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showFortfolio)
            Spacer()
            ButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(!showFortfolio ? 0 : 180))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showFortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
extension ContentView {
    var columnTitles: some View {
        HStack {
            Group {
                Text("Coin")
                    .foregroundColor(Color.theme.themeSecondary)
                    .font(.caption)
                    .padding(.leading, 20)
                Image(systemName: "chevron.up")
                    .foregroundColor(Color.theme.themeSecondary)
                    .font(.caption)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 180 : 0))
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed
                             ? 1.0 : 0.0)
            }.onTapGesture {
                vm.sortOption = (vm.sortOption == .rank ? .rankReversed : .rank)
            }
            Spacer()
            if showFortfolio {
                HStack(spacing: 5) {
                    Text("Holding")
                        .foregroundColor(Color.theme.themeSecondary)
                        .font(.caption)
                    Image(systemName: "chevron.up")
                        .foregroundColor(Color.theme.themeSecondary)
                        .font(.caption)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 180 : 0))
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed
                                 ? 1.0 : 0.0)
                }.frame(width: UIScreen.main.bounds.width / 4, alignment: .leading)
                .onTapGesture {
                    vm.sortOption = (vm.sortOption == .holdings ? .holdingsReversed : .holdings)
                }
            }
            HStack {
                HStack {
                    Text("Price")
                        .foregroundColor(Color.theme.themeSecondary)
                        .font(.caption)
                    Image(systemName: "chevron.up")
                        .foregroundColor(Color.theme.themeSecondary)
                        .font(.caption)
                        .rotationEffect(Angle(degrees: vm.sortOption == .price ? 180 : 0))
                        .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed
                                 ? 1.0 : 0.0)
                }
                .onTapGesture {
                    vm.sortOption = (vm.sortOption == .price ? .priceReversed : .price)
                }
                Button {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reload()
                    }
                } label: {
                    Image(systemName: "goforward")
                        .font(.caption)
                        .foregroundColor(Color.theme.themeSecondary)
                        .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
                }.padding(.trailing, 20)
            } // Price + 정렬버튼 + 새로고침버튼
            .frame(width: UIScreen.main.bounds.width / 4 + 10)
        }
        .padding(.top, 10)
    }
    var allCoinLists: some View {
        List {
            ForEach(vm.coins) { coin in
                CoinRowView(coin: coin, isFortfolio: false)
                    .padding(.vertical, 10)
            }
        }.listStyle(PlainListStyle())
    }
    var fortfolioLists: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isFortfolio: true)
                    .padding(.vertical, 10)
            }
            
        }.listStyle(PlainListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(dev.homeVM)
            ContentView()
                .environmentObject(dev.homeVM)
                .preferredColorScheme(.dark)
        }
        
    }
}
