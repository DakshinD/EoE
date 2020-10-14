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
                
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .opacity(0.8)
                            .foregroundColor(Color("lightPurple"))
                            .frame(width: 130, height: 130)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("darkPurple"))
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear)
                            .frame(width: 130, height: 130)
                        
                        Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                            .font(.system(size: 35, weight: .semibold, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Text("Processing image...")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding()

                }
                .padding(.top, 25)
                .frame(width: 170, height: 215)
                .background(Color("black3"))
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
