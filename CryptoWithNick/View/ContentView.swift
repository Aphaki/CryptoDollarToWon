//
//  ContentView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var isDollar: Bool = true
    @State private var showFortfolio = false
    @State private var showFortfolioView = false
    @State private var showInfoView = false
    @State private var launchLoading = true
    @EnvironmentObject private var vm: ContentViewModel
    
    var body: some View {
        ZStack {
            // 배경화면 + sheet(포트폴리오 EditView) + 네비게이션 링크(DetailView) 설정
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showFortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
                .sheet(isPresented: $showInfoView, content: {
                    InfoView()
                })
                .background(
                    NavigationLink(isActive: $showDetailView,
                                   destination: { DetailLoadingView(coin: $selectedCoin, isDollar: $isDollar) },
                                   label: {EmptyView()})
                )
            // 헤더 (버튼 + 타이틀 + 버튼)
            // 스탯뷰 (시총 + 거래량 + 비트코인비율 + 포트폴리오 하루 변동성)
            // 서치바
            // 칼럼 타이틀( coin , holdings, price, reload 버튼 )
            VStack {
                headerView
                    .padding(.horizontal, 10)
                HomeStatsView(showPortfolio: $showFortfolio, isDollar: $isDollar)
                    .padding()
                SearchBarView(searchBarText: $vm.searchBarText)
                    .padding(.horizontal, 20)
                columnTitles
                // 코인 리스트 (올 코인 or 포트폴리오 코인)
                if !showFortfolio {
                    allCoinLists
                        .transition(.move(edge: .leading))
                        .padding(.horizontal, 10)
                } else {
                    ZStack(alignment: .top) {
                        fortfolioLists
                            .padding(.horizontal, 10)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            // 로딩뷰
            if launchLoading {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.launchLoading = false
                        }
                    }
            }
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
                    } else {
                        showInfoView.toggle()
                    }
                }
                .background(
                    CircleButtonAnymationView(animate: $showFortfolio)
                )
            ButtonView(iconName: isDollar ? "wonsign.circle.fill" : "dollarsign.circle.fill")
                .onTapGesture {
                    if isDollar {
                        isDollar = false
                    } else {
                        isDollar = true
                    }
                }
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
    var columnTitles: some View {
        HStack(spacing: 0) {
            HStack {
                Text("Coin")
                    .foregroundColor(Color.theme.themeSecondary)
                    .font(.caption)
                    .padding(.leading , 30)
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
            HStack(spacing: 0) {
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
            ForEach(isDollar ? vm.coins : vm.krwCoins) { coin in
                CoinRowView(coin: coin, isFortfolio: false, isDollar: $isDollar)
                    .padding(.vertical, 10)
                    .listRowBackground(Color.theme.background)
                    .onTapGesture {
                        selectedCoin = coin
                        showDetailView.toggle()
                    }
            }
        }.listStyle(PlainListStyle())
    }
    var fortfolioLists: some View {
        List {
            ForEach(isDollar ? vm.portfolioCoins : vm.krwPortfolioCoins) { coin in
                CoinRowView(coin: coin, isFortfolio: true, isDollar: $isDollar)
                    .padding(.vertical, 10)
                    .listRowBackground(Color.theme.background)
                    .onTapGesture {
                        selectedCoin = coin
                        showDetailView.toggle()
                    }
                
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
