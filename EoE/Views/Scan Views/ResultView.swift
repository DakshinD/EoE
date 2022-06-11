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
                                .foregroundColor(Color.text)
                            Spacer()
                            Text("😁")
                        }
                    } else {
                        ForEach(scanningProcess.foundAllergens, id: \.self) { allergen in
                            HStack {
                                // Check how to handle this optional
                                Text(AllergenTypes(rawValue: allergen)!.description)
                                    .foregroundColor(Color.text)
                                Spacer()
                                Text(AllergenTypes(rawValue: allergen)!.emoji)
                            }
                        }

                    }
                }
                .listRowBackground(Color.secondary)
                
                Section(header: Text("Found Extra Allergens")) {
                    if scanningProcess.foundUserCreatedAllergens.isEmpty {
                        HStack {
                            Text("No Extra Allergens Found!")
                                .foregroundColor(Color.text)
                            Spacer()
                            Text("😁")
                        }
                    } else {
                        ForEach(scanningProcess.foundUserCreatedAllergens, id: \.self) { allergen in
                            HStack {
                                // Check how to handle this optional
                                Text(allergen)
                                    .foregroundColor(Color.text)
                                Spacer()
                                //Text(AllergenTypes(rawValue: allergen)!.emoji)
                            }
                        }

                    }
                }
                .listRowBackground(Color.secondary)

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
