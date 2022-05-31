//
//  PortfolioView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/30.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var vm: ContentViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    SearchBarView(searchBarText: $vm.searchBarText)
                        .padding(.vertical, 20)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "xmark.circle")
                        .onTapGesture { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchBarText, perform: { value in
                if value == "" {
                    removeSelectedCoin()
                }
            })
        } //NavigationView
    }
}
extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchBarText.isEmpty ? vm.portfolioCoins : vm.coins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.themeGreen
                                        : .clear, lineWidth: 1)
                        )
                }
            } //LazyHStack
            .padding(.vertical, 5)
            .padding(.leading, 10)
        }
    }
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else { quantityText = "" }
    }
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private var portfolioInputSection: some View {
        VStack {
            HStack {
                Text("Current price of \(selectedCoin!.symbol.uppercased()):")
                Spacer()
                Text(selectedCoin!.currentPrice.asCurrencyWith2Demicals())
                
            }.animation(.none, value: selectedCoin?.id)
            Divider()
            HStack {
                Text("Amount in your portfolio:")
                    .font(.caption)
                Spacer()
                TextField("Ex. 0.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Demicals())
            }
        }
        .padding(.horizontal, 10)
    }
    private var trailingNavBarButtons: some View {
        HStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color.theme.themeGreen)
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))
                ? 1.0 : 0.0)
        } .font(.headline)
        
    }
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        // 포트폴리오 저장
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // 키보드 숨기기
        UIApplication.shared.endEditing()
        
        // 체크마크 보이기
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // 체크마크 숨기기
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
        
    }
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchBarText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
