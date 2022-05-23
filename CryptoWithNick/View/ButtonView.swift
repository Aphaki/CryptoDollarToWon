//
//  ButtonView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

struct ButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.title2)
            .foregroundColor(Color.theme.accent)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
                    .frame(width: 50, height: 50)
            )
            .shadow(color: Color.theme.accent.opacity(0.3), radius: 10, x: 0, y: 0)
            .frame(width: 60, height: 60)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView(iconName: "info.circle.fill")
                .previewLayout(.sizeThatFits)
            ButtonView(iconName: "info.circle.fill")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
