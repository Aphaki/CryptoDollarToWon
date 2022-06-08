//
//  ChartView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/06.
//

import SwiftUI

struct ChartView: View {
    
    private let priceArray: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        priceArray = coin.sparklineIn7D?.price ?? []
        maxY = priceArray.max() ?? 0
        minY = priceArray.min() ?? 0
        
        // 선 색깔
        let priceChange = (priceArray.last ?? 0) - (priceArray.first ?? 0)
        lineColor = priceChange >= 0 ? Color.theme.themeGreen : Color.theme.themeRed
        
        // 차트 날짜
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(alignment: .leading) { yAxisPrice.padding(.leading, 4) }
            chartDate
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.themeSecondary)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader{ geometry in
            Path { path in
                for index in priceArray.indices {
                    let xPosition = geometry.size.width * CGFloat(index + 1) / CGFloat(priceArray.count)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((priceArray[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }// Path
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        } //GeometryReader
    }
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var yAxisPrice: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text( ((maxY + minY) / 2).formattedWithAbbreviations() )
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    private var chartDate: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
