//
//  CameraLoadingAnimation.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/30/20.
//

import SwiftUI

struct CameraLoadingAnimation: View {
    
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var backgroundColor: Color
    var imageColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            Image(systemName: "viewfinder.circle")
                .renderingMode(.template)
                .resizable()
                .frame(width: 55, height: 55)
                .foregroundColor(imageColor)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0), anchor: .center)
                .animation(self.isAnimating ? foreverAnimation : .default)
                .onAppear { self.isAnimating = true }
                .onDisappear { self.isAnimating = false }
        }

    }
}

struct CameraLoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            CameraLoadingAnimation(backgroundColor: Color("darkPurple"), imageColor: .white)
        }
    }
}
