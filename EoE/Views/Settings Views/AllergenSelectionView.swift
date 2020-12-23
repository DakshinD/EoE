//
//  AllergenSelectionView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI
import CoreData

struct AllergenSelectionView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(
        entity: Allergen.entity(),
        sortDescriptors: []
    ) var allergens: FetchedResults<Allergen>
    
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            List {
                
                Section(header: Text("")) {
                    ForEach(allergens, id: \.self) { allergen in
                        HStack {
                            Text(allergen.name ?? "Unkown Allergen")
                                .foregroundColor(Color.text)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                        
                                    allergen.isSelected.toggle()
                                    
                                    do {
                                        try managedObjectContext.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }

                                }
                            }) {
                                Image(systemName: allergen.isSelected ? "checkmark.circle.fill" : "circle")
                                    .renderingMode(.template)
                                    .foregroundColor(allergen.isSelected ? Color.accent : Color.text)
                                    .animation(.spring())
                            }
                        }
                    }
                }
                .listRowBackground(Color.secondary)
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Allergen Selection")
    }
    
}

struct AllergenSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AllergenSelectionView()
    }
}
