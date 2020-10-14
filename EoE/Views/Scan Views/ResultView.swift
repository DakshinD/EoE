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
                Section(header: Text("Found Allergens")) {
                    if scanningProcess.foundAllergens.isEmpty {
                        HStack {
                            Text("No Allergens Found!")
                                .foregroundColor(.white)
                            Spacer()
                            Text("😁")
                        }
                    } else {
                        ForEach(scanningProcess.foundAllergens, id: \.self) { allergen in
                            HStack {
                                // Check how to handle this optional
                                Text(AllergenTypes(rawValue: allergen)!.description)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(AllergenTypes(rawValue: allergen)!.emoji)
                            }
                        }

                    }
                }
                .listRowBackground(Color("black3"))

            }
            .listStyle(InsetGroupedListStyle())
//            .padding(.top, 10)
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
