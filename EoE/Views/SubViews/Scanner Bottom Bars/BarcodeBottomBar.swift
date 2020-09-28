//
//  BarcodeBottomBar.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct BarcodeBottomBar: View {
    
    @Binding var scanningState: ScanningState

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.scanningState != ScanningState.searching && self.scanningState != ScanningState.closed {
                    DirectionText()
                }
                
                HStack(alignment: .bottom) {
                    EmptyView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .background(Color.white.shadow(radius: 2))
                .overlay(CancelButton(scanningState: self.$scanningState))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DirectionText: View {
    @State private var flash: Bool = true
    
    private let animation = Animation.easeInOut(duration: 1.75).repeatForever(autoreverses: true)
    
    var body: some View {
        Text("Looking for barcode...")
            .padding()
            .font(.custom("Poppins-SemiBold", size: 13))
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(Color.white.opacity(0.8)))
            .opacity(flash ? 1.0 : 0.0)
            .offset(y: -58)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.25) {
                    withAnimation(self.animation, {
                        self.flash.toggle()
                    })
                }
            }
    }

}

struct CancelButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var scanningState: ScanningState
    
    var body: some View {
        Button(action: {
            self.scanningState = .closed
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .padding(.all, 25)
                .background(Color.red)
                .clipShape(Circle())
        }
        .offset(y: -50)
    }
}

struct BarcodeBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        //BarcodeBottomBar()
        Text("")
    }
}
