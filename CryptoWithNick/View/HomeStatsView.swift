//
//  HomeStatsView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/29.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: ContentViewModel
    
    @Binding var showPortfolio: Bool
    @Binding var isDollar: Bool
    
    var body: some View {
        HStack {
            ForEach(isDollar ? vm.statistics : vm.krwStatistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width , alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false), isDollar: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
