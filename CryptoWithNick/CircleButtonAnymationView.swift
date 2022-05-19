//
//  CircleButtonAnymationView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/19.
//

import SwiftUI

struct CircleButtonAnymationView: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(.easeInOut(duration: 1.3), value: animate)
    }
}

struct CircleButtonAnymationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnymationView(animate: .constant(false))
            .foregroundColor(Color.theme.themeRed)
            .frame(width: 100, height: 100)
    }
}
