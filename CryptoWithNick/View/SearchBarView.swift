//
//  SerchBarView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/26.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchBarText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 15)
            TextField("Search by name or symbol", text: $searchBarText)
                .disableAutocorrection(true)
                .font(.headline)
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.theme.background)
                    .shadow(color: Color.theme.accent, radius: 10, x: 0, y: 0)
                    .opacity(0.4)
                    .padding(.horizontal, 10)
            )
            .overlay {
                if !searchBarText.isEmpty {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchBarText = ""
                            }
                        Spacer()
                            .frame(width: 20)
                    }
                }
            }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchBarText: .constant(""))
    }
}
