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
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    List {
                        
                        Section(header: Text("Description").bold()) {
                            Text(scan.wrappedProductName)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Date Scanned").bold()) {
                            Text(scan.wrappedDate, style: .date)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Allergens Found").bold()) {
                            if !scan.foundAllergensArray.isEmpty {
                                ForEach(scan.foundAllergensArray, id: \.self) { allergen in
                                    HStack {
                                        // Check if we need to handle this optional properly
                                        Text(AllergenTypes(rawValue: allergen.wrappedType)!.description)
                                        Spacer()
                                        Text(AllergenTypes(rawValue: allergen.wrappedType)!.emoji)
                                    }
                                }
                            } else {
                                HStack {
                                    Text("No Allergens Found!")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("😁")
                                }
                            }
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Ingredients").bold()) {
                            Text(formattedIngredients(scan.wrappedIngredients))
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color("black3"))
                        
                        Button(action: {
                            withAnimation {
                                showNutritionalInfo.toggle()
                            }
                        }) {
                            HStack {
                                Text("Nutritional Value per 100 g")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.up.circle")
                                    .foregroundColor(.white)
                                    .rotationEffect(Angle(degrees: showNutritionalInfo ? 180 : 0))
                                    .animation(.default)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        if showNutritionalInfo {
                            ForEach(scan.nutrientsArray, id: \.self) { nutrient in
                                HStack {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.white)
                                    Text(fixedDescriptionString(nutrient.wrappedNutrientName))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("\(nutrient.value.truncate(places: 2)) " + nutrient.wrappedUnitName.lowercased())
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color("black3"))
                            .animation(.default)
                        }
                        
                        
                        
                       /* Section(header: Text("Nutritional Value per 100 g").bold()) {
                        }
                        .listRowBackground(Color("black3"))*/

                        
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
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
