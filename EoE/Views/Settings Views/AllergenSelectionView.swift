//
//  AllergenSelectionView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI

struct AllergenSelectionView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            List {
                
                Section(header: Text("")) {
                    ForEach(userData.allAllergens) { allergen in
                        HStack {
                            Text(allergen.name)
                                .foregroundColor(.white)
                                .bold()
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    // Unselecting allergen
                                    if let index = userData.selectedAllergens.firstIndex(where: {$0.name == allergen.name}) {
                                        
                                        userData.selectedAllergens[index].isSelected.toggle()
                                        
                                        // Removing allergen from selected array
                                        userData.selectedAllergens.remove(at: index)
                                        
                                        // Changing selected status in overarching array
                                        if let totalIndex = userData.allAllergens.firstIndex(where: {$0.name == allergen.name}) {
                                            userData.allAllergens[totalIndex].isSelected.toggle()
                                        } else {
                                            print("Could not find allergen")
                                        }
                                        
                                    }
                                    // Selecting Allergen
                                    else {
                                        
                                        if let totalIndex = userData.allAllergens.firstIndex(where: {$0.name == allergen.name}) {
                                            
                                            userData.allAllergens[totalIndex].isSelected.toggle()
                                            
                                            // Adding allergen to selected array
                                            userData.selectedAllergens.append(userData.allAllergens[totalIndex])
                                        } else {
                                            print("Could not find allergen")
                                        }
                                        
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
