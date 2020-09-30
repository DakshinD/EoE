//
//  FloatingScanButton.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/29/20.
//

import SwiftUI

struct FloatingScanButton: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("darkPurple"))
                .frame(width: 60, height: 60)
                .shadow(radius: 5)
            
            Image(systemName: "viewfinder")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
        }
    }
}

struct FloatingScanButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingScanButton()
    }
}
