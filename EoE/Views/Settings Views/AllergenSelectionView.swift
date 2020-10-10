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
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            List {
                
                Section(header: Text("")) {
                    ForEach(allergens, id: \.self) { allergen in
                        HStack {
                            Text(allergen.name ?? "Unkown Allergen")
                                .foregroundColor(.white)
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
                                    .foregroundColor(allergen.isSelected ? Color("darkPurple") : .white)
                                    .animation(.spring())
                            }
                        }
                    }
                }
                .listRowBackground(Color("black3"))
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Allergen Selection")
        .onAppear {
            for allergen in allergens {
                print(allergen.name)
                print(allergen.type)
            }
        }
    }
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        // Changes to List
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().separatorColor = UIColor.gray
    }
    
}

struct AllergenSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AllergenSelectionView()
    }
}
