//
//  IngredientsScanButton.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/29/20.
//

import SwiftUI

struct IngredientsScanButton: View {
    var body: some View {
        Button(action: {
            
        }) {
            ZStack {
                Circle()
                    .foregroundColor(Color("darkPurple"))
                    .frame(width: 50, height: 50)
                    .shadow(radius: 5)
                
                Image(systemName: "doc.text.viewfinder")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            }
        }
        .offset(x: -3, y: -72)
        .animation(.default)
        .transition(AnyTransition.opacity.combined(with: .asymmetric(insertion: AnyTransition.move(edge: .bottom), removal: AnyTransition.move(edge: .bottom))))
    }
}

struct IngredientsScanButton_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsScanButton()
    }
}
