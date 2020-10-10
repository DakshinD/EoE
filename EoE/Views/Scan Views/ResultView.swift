//
//  ResultView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/9/20.
//

import SwiftUI

struct ResultView: View {
        
    @EnvironmentObject var scanningProcess: ScanningProcess
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Found Allergens")
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                .listRowBackground(Color("black3"))

                ForEach(scanningProcess.foundAllergens, id: \.self) { allergen in
                    HStack {
                        // Check how to handle this optional
                        Text(AllergenTypes(rawValue: allergen)!.description)
                            .foregroundColor(.white)
                        Spacer()
                        Text(AllergenTypes(rawValue: allergen)!.emoji)
                    }
                }
                .listRowBackground(Color("black3"))

            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Product Analysis")
    }
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //ResultView(foundAllergens: ["wheat", "dairy", "soy", "peanuts"])
    }
}
