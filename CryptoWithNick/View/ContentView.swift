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
            List {
                VStack {
                    ForEach(vm.coins) { coin in
                        CoinRowView(coin: coin, isFortfolio: $showFortfolio)
                            .padding(.vertical, 10)
                    }
                }
            }.listStyle(PlainListStyle())
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
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
            Text("Price")
                .foregroundColor(Color.theme.themeSecondary)
                .font(.caption)
                .padding(.trailing, 20)
        }.padding(.top, 10)
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
