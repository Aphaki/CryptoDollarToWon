//
//  InfoView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/14.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let coingeckoURL: URL = URL(string: "https://www.coingecko.com/ko")!
    let koreaeximURL: URL = URL(string: "https://www.koreaexim.go.kr/index")!
    let swiftfulThinkingURL: URL = URL(string: "https://www.youtube.com/c/SwiftfulThinking")!
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    Section {
                        Image("coingecko")
                            .resizable()
                            .frame(height: 100)
                        Text("이 앱에 사용된 코인의 가격 데이터는 코인게코 API 입니다. 무료 API로 실시간 가격에 살짝 딜레이가 있을 수 있습니다.")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                        Link("🦎 코인게코 방문하기", destination: coingeckoURL )
                            .foregroundColor(Color.theme.themeBlue)
                    }
                    Section {
                        HStack(spacing: 20) {
                            Image("koreaexim")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            Text("한국수출입은행")
                                .font(.largeTitle)
                                .foregroundColor(Color.theme.themeSecondary)
                                .fontWeight(.heavy)
                        }
                        Text("이 앱에 적용된 환율 데이터는 한국수출입은행의 환율에 의하며 은행 영업시간 이외엔 그전에 발표된 가장 최근 날짜의 환율이 적용됩니다.")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                        Link("🏦 한국수출입은행 사이트 방문하기", destination: koreaeximURL)
                            .foregroundColor(Color.theme.themeBlue)
                    }
                    Section {
                        Text("About This App")
                            .font(.largeTitle)
                            .foregroundColor(Color.theme.themeSecondary)
                        Text("이 앱은 MVVM 아키텍처로 Combine과 CoreData, SwiftUI 프레임워크들로 구성되었고, Lottie 라이브러리로 로딩뷰를 구성했습니다. 코인게코에서의 서버요청은 비교적 안정적인 편이지만, 한국수출입은행의 환율은 쉬는날엔 빈값이 나와서 그 이전에 나온 최근의 환율이 적용되게끔 설계했습니다. 환율도 실시간이라기 보단 당일 어느시점의 환율이 적용된 것으로 보이므로 오차범위 10원쯤으로 감안하시고 보시면 될 것 같습니다. 앱 상단의 마켓데이터 부분 토탈 시총은 단순히 달러일때의 시총에 환율을 곱한것이고 원화로 거래된 시총을 의미한것이 아닌점을 확실히 합니다.")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                    }

                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "xmark")                            .foregroundColor(Color.theme.accent)
                            .padding(.vertical, 20)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                })
                .listStyle(.plain)
                .navigationTitle("Infomation")
            }
        }

    }
}

extension InfoView {
    private var coingeckoView: some View {
        List {
            Text("coingecko".uppercased())
                .foregroundColor(Color.theme.themeSecondary)
                .font(.headline)
            Image("coingecko")
                .resizable()
                .frame(height: 100)
            Text("이 앱에 사용된 코인의 가격 데이터는 코인게코 API 입니다. 무료 API로 실시간 가격에 살짝 딜레이가 있을 수 있습니다.")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            Link("🦎 코인게코 방문하기", destination: coingeckoURL )
                .foregroundColor(Color.theme.themeBlue)

        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .preferredColorScheme(.dark)
    }
}
