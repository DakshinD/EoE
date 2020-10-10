//
//  ScanRow.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI

struct ScanRow: View {
    
    var scan: Scan
    
    var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(scan.productName ?? "Unkown Product")
                        .foregroundColor(.white)
                        .bold()
                    Text(scan.dateScanned ?? Date(), style: .date) // Fix the optional value for this
                        .font(.caption)
                        .foregroundColor(Color("gray1"))
                        .bold()
                }
                Spacer()
                HStack {
                    ForEach(scan.foundAllergensArray, id: \.self) { allergen in
                        ZStack {

                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(AllergenTypes(rawValue: allergen.type!)!.color)
                            
                            Text(AllergenTypes(rawValue: allergen.type!)!.symbol)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                        }
                    }
                }
                
            }
            .padding()
            //.background(Color("black3"))
    }
}

struct ScanRow_Previews: PreviewProvider {
    static var previews: some View {
        //ScanRow(scan: Scan(dateScanned: Date(), productName: "Popcorn", ingredients: "Corn, Sunflower Oil, Sea Salt, Palm Oil", foundAllergens: [Allergen(name: "Wheat", type: .shellfish, isSelected: true)]))
        Text("a")
    }
}
