//
//  CameraView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct CameraView: View {
    @State var image: UIImage? = nil
    @State var didTapCapture: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    CustomCameraRepresentable(image: self.$image, didTapCapture: self.$didTapCapture)
                        .frame(width: geometry.size.width, height: geometry.size.height-geometry.size.height/8)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
                
                CameraBottomBar().onTapGesture {
                    self.didTapCapture = true
                }
                
            }
        }
    }
}


struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
