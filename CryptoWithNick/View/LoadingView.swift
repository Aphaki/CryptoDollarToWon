//
//  LoadingView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/15.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            LottieView(fileName: "BTCLoading")
                    .frame(width: 400, height: 400)
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
