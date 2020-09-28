//
//  CameraBottomBar.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct CameraBottomBar: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    EmptyView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .background(Color.white.shadow(radius: 2))
                .overlay(CaptureButton())
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CaptureButton: View {
    
    var body: some View {
        Image(systemName: "camera")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 50, height: 40)
            .padding(.all, 25)
            .background(Color("lightPurple"))
            .clipShape(Circle())
            .offset(y: -50)
    }
}

struct CameraBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        CameraBottomBar()
    }
}
