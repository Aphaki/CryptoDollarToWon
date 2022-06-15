//
//  LottieView.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/06/15.
//

import Foundation
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    
    var fileName: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        animationView.animation = Animation.named(fileName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate ( [
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ] )
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    typealias UIViewType = UIView
    
}
