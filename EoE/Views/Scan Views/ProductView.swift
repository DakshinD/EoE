//
//  ProductView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/30/20.
//

import SwiftUI

struct ProductView: View {
    
    @State private var showNutritionalInfo: Bool = false
    
    var scan: Scan

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    List {
                        
                        Section(header: Text("Description").bold()) {
                            Text(scan.wrappedProductName)
                                .foregroundColor(Color.text)
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Date Scanned").bold()) {
                            HStack {
                                Text(scan.wrappedDate, style: .date)
                                    .foregroundColor(Color.text)
                                
                                Text(scan.wrappedDate, style: .time)
                                    .foregroundColor(Color.text)

                            }
                            
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Allergens Found").bold()) {
                            if !scan.foundAllergensArray.isEmpty {
                                ForEach(scan.foundAllergensArray, id: \.self) { allergen in
                                    if AllergenTypes(rawValue: allergen.type!) != AllergenTypes.userCreated {
                                        HStack {
                                            // Check if we need to handle this optional properly
                                            Text(AllergenTypes(rawValue: allergen.wrappedType)!.description)
                                            Spacer()
                                            Text(AllergenTypes(rawValue: allergen.wrappedType)!.emoji)
                                        }
                                        .foregroundColor(Color.text)
                                    }
                                }
                            } else {
                                HStack {
                                    Text("No Allergens Found!")
                                        .foregroundColor(Color.text)
                                    Spacer()
                                    Text("😁")
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Found Extra Allergens").bold()) {
                            if scan.foundAllergensArray.isEmpty {
                                HStack {
                                    Text("No Extra Allergens Found!")
                                        .foregroundColor(Color.text)
                                    Spacer()
                                    Text("😁")
                                }
                            } else {
                                ForEach(scan.foundAllergensArray, id: \.self) { allergen in
                                    if AllergenTypes(rawValue: allergen.type!) == AllergenTypes.userCreated {
                                        HStack {
                                            // Check how to handle this optional
                                            Text(allergen.name!)
                                                .foregroundColor(Color.text)
                                            Spacer()
                                            //Text(AllergenTypes(rawValue: allergen)!.emoji)
                                        }
                                    }
                                }

                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Ingredients").bold()) {
                            Text(formattedIngredients(scan.wrappedIngredients))
                                .foregroundColor(Color.text)
                        }
                        .listRowBackground(Color.secondary)
                        
                        Button(action: {
                            withAnimation {
                                showNutritionalInfo.toggle()
                            }
                        }) {
                            HStack {
                                Text("Nutritional Value per 100 g")
                                    .foregroundColor(Color.text)
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.up.circle")
                                    .foregroundColor(Color.text)
                                    .rotationEffect(Angle(degrees: showNutritionalInfo ? 180 : 0))
                                    .animation(.default)
                            }
                            .padding(.vertical, 10)
                        }
                        .listRowBackground(Color.secondary)
                        
                        if showNutritionalInfo {
                            ForEach(scan.nutrientsArray, id: \.self) { nutrient in
                                HStack {
                                    Text(fixedDescriptionString(nutrient.wrappedNutrientName))
                                        .foregroundColor(Color.text)
                                    Spacer()
                                    Text("\(nutrient.value.truncate(places: 2)) " + nutrient.wrappedUnitName.lowercased())
                                        .foregroundColor(Color.text)
                                }
                            }
                            .listRowBackground(Color.secondary)
                            .animation(.default)
                        }

                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .padding(.top, 20)

                
            }
            .navigationTitle("Information")
        }
    }
    
    func formattedIngredients(_ ingredients: String) -> String {
        var newStr = ingredients.lowercased()
        newStr.capitalizeFirstLetter()
        return newStr
    }
    
    func fixedDescriptionString(_ descr: String) -> String {
        let delimiter = ","
        let names = descr.components(separatedBy: delimiter)
        var formattedName = names[0].lowercased()
        formattedName.capitalizeFirstLetter()
        return formattedName
        
    }
    
    init(scan: Scan) {
        // Initializing variables
        self.scan = scan
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
