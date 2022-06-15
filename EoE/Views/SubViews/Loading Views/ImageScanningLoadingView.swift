//
//  ImageScanningLoadingView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/13/20.
//

import SwiftUI

struct ImageScanningLoadingView: View {
    
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                Color.background
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .opacity(0.8)
                            .foregroundColor(Color.accentSecondary)
                            .frame(width: 130, height: 130)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.accent)
                            .rotationEffect(Angle(degrees: 270.0))
                            //.animation(.linear)
                            .animation(.linear, value: progress)
                            .frame(width: 130, height: 130)
                        
                        Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                            .font(.system(size: 35, weight: .semibold, design: .rounded))
                            .bold()
                            .foregroundColor(Color.text)
                    }
                    
                    Text("Processing image...")
                        .foregroundColor(Color.text)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding()

                }
                .padding(.top, 25)
                .frame(width: 170, height: 215)
                .background(Color.background)
                .cornerRadius(15)

            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }
        
    }
    
}

struct ImageScanningLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageScanningLoadingView(progress: .constant(0.5))
    }
}
