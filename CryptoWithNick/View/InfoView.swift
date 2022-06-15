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
                        Text("Swiftful Thinking")
                            .font(.largeTitle)
                            .foregroundColor(Color.theme.themeSecondary)
                        Text("이 앱은 MVVM 아키텍처로 Combine과 CoreData, SwiftUI 프레임워크들로 구성되었습니다. 환율 적용하는 부분은 직접 구현했지만 이외의 기초적인 기틀은 유튜브 Swiftful Thinking을 참고하여 만들어졌습니다. 기술적인 구현이 궁금하신 분들은 아래 사이트를 방문하면 Nick이 친절하게 설명하는 유튜브를 보실 수 있습니다.")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                        Link("🖥 유튜브 보러가기", destination: swiftfulThinkingURL)
                            .foregroundColor(Color.theme.themeBlue)
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
