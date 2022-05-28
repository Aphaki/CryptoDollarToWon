//
//  ContentView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

struct ContentView: View {
    @State var showFortfolio = false
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            headerView
            SearchBarView(searchBarText: $vm.searchBarText)
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
            
        }
    }
}
extension ContentView {
    var headerView: some View {
        HStack {
            ButtonView(iconName: !showFortfolio ? "info" : "plus")
                .animation(.none, value: showFortfolio)
                .background(
                CircleButtonAnymationView(animate: $showFortfolio)
                )
            Spacer()
            Text(!showFortfolio ? "Live Prices" : "Fortfolio")
                .font(.headline)
                .fontWeight(.heavy)
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
            Text("Coin")
                .foregroundColor(Color.theme.themeSecondary)
                .font(.caption)
                .padding(.leading, 20)
            Spacer()
            if showFortfolio {
                Text("Holding")
                    .foregroundColor(Color.theme.themeSecondary)
                    .font(.caption)
                    .padding(.trailing, 10)
            }
            Text("Price")
                .foregroundColor(Color.theme.themeSecondary)
                .font(.caption)
                .padding(.trailing, 20)
                .frame(width: UIScreen.main.bounds.width / 4)
        }.padding(.top, 10)
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
            CoinRowView(coin: DeveloperPreview.shared.coin, isFortfolio: true)
                .padding(.vertical, 10)
        }.listStyle(PlainListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        
    }
}
