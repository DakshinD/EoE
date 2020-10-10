//
//  BarcodeScanButton.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/29/20.
//

import SwiftUI

struct BarcodeScanButton: View {
    
    @EnvironmentObject var scanningProcess: ScanningProcess

    var body: some View {
        Button(action: {
            print("Barcode button pressed")
            scanningProcess.barcodeScannerShowing.toggle()
            scanningProcess.scanningState = .cameraLoading
        }) {
            ZStack {
                Circle()
                    .foregroundColor(Color("darkPurple"))
                    .frame(width: 50, height: 50)
                    .shadow(radius: 5)
                
                Image(systemName: "barcode.viewfinder")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            }
        }
        .transition(AnyTransition.opacity.combined(with: .asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .trailing))))
    }
}

struct BarcodeScanButton_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScanButton()
    }
}
