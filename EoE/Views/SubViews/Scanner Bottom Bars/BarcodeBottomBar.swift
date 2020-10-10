//
//  BarcodeBottomBar.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct BarcodeBottomBar: View {
    
    @EnvironmentObject var scanningProcess: ScanningProcess
    @Binding var scanningState: ScanningState

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            if scanningProcess.scanningState == ScanningState.cameraLoaded {
                DirectionText()
            }
            
            CancelButton(scanningState: $scanningState)
        }
        .padding(.bottom, 50)
    }
}



struct DirectionText: View {
    @State private var flash: Bool = true
    
    private let animation = Animation.easeInOut(duration: 1.75).repeatForever(autoreverses: true)
    
    var body: some View {
        Text("Looking for barcode...")
            .padding()
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(Color.white.opacity(0.8)))
            .opacity(flash ? 1.0 : 0.0)
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
    @EnvironmentObject var scanningProcess: ScanningProcess
    
    var body: some View {
        Button(action: {
            scanningState = .closing
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                scanningState = .closed
                withAnimation {
                    scanningProcess.barcodeScannerShowing.toggle()
                }
            }

        }) {
            ZStack {
                Capsule()
                    .foregroundColor(.red)
                    .frame(width: 200, height: 50)
                    .shadow(radius: 5)
                
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Cancel")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.leading, 2)
                }
                
            }
        }
    }
}

struct BarcodeBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeBottomBar(scanningState: .constant(ScanningState.cameraLoading))
    }
}
