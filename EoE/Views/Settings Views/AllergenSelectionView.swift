//
//  AllergenSelectionView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI
import CoreData

struct AllergenSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(
        entity: Allergen.entity(),
        sortDescriptors: []
    ) var allergens: FetchedResults<Allergen>
    
    @State private var showAlert: Bool = false
    @State private var allergenText: String = ""
    
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                if needsAppOnboarding {
                    HStack {
                        Text("Allergen Selection")
                            .foregroundColor(Color.text)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding()
                }
                
                List {
                    
                    Section(header: Text("Allergens")) {
                        ForEach(allergens, id: \.self) { allergen in
                            if AllergenTypes(rawValue: allergen.type!) ?? AllergenTypes.userCreated != AllergenTypes.userCreated {
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
                    }
                    .listRowBackground(Color.secondary)
                    
                    Section(header:
                                HStack {
                                    Text("Extra Allergens")
                                    Spacer()
                                    Button(action: {
                                        // show alert to let user add new allergen
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(Color.accent)
                                    }
                                }
                            , footer: Text("Disclaimer: Only the exact name you type will be used to search for the allergen. Make sure to type the allergen's name correctly.")) { //AllergenTypes.peanuts below is placeholder for optional
                        if isThereUserCreatedAllergen() == true {
                            ForEach(allergens, id: \.self) { allergen in
                                if AllergenTypes(rawValue: allergen.type!) ?? AllergenTypes.peanuts == AllergenTypes.userCreated {
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
                            .onDelete(perform: removeExtraAllergen)
                        } else {
                            // there is no user created allergen
                            HStack {
                                Text("Add in your own allergens that you want to check for when scanning labels!")
                                    .foregroundColor(Color.text)
                                Spacer()
                            }
                        }
                        //----
                        /*if userData.allergenOptions.count != 0 {
                            ForEach(userData.allergenOptions, id: \.self) { allergen in
                                HStack {
                                    Text(allergen)
                                        .foregroundColor(Color.text)
                                    Spacer()
                                }
                            }
                            .onDelete(perform: deleteAllergen)
                        } else {
                            HStack {
                                Text("Add in your own allergens that you want to check for when scanning labels!")
                                Spacer()
                            }
                        }*/
                        
                    }
                    .listRowBackground(Color.secondary)
                    
                }
                .listStyle(InsetGroupedListStyle())
                
                if needsAppOnboarding {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Finished")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    .buttonStyle(CustomButton())
                    .frame(width: 300, height: 50)
                    .padding()
                }
            }
            
            if showAlert {
                UserAllergenAlertControl(moc: managedObjectContext, textString: $allergenText, showAlert: $showAlert, title: "New Allergen", message: "Type in the name of your allergen", currentOptions: $userData.allergenOptions)
            }
        }
        .navigationTitle("Allergen Selection")
        .preferredColorScheme(userData.darkMode ? .dark : .light)
    }
    
    func deleteAllergen(at offsets: IndexSet) {
        userData.allergenOptions.remove(atOffsets: offsets)
    }
    
    func isThereUserCreatedAllergen() -> Bool {
        for allergen in allergens {
            if AllergenTypes(rawValue: allergen.type!) ?? AllergenTypes.peanuts == AllergenTypes.userCreated {
                return true
            }
        }
        return false
    }
    
    func removeExtraAllergen(at offsets: IndexSet) {
        for index in offsets {
            let allergen = allergens[index]
            managedObjectContext.delete(allergen)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
            // handle the Core Data error
        }
    }
    
}

struct AllergenSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AllergenSelectionView()
    }
}
