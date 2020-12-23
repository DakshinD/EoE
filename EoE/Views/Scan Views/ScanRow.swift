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
                        .foregroundColor(Color.text)
                        .bold()
                    Text(scan.dateScanned ?? Date(), style: .date) // Fix the optional value for this
                        .font(.caption)
                        .foregroundColor(Color.gray) // previously gray1
                        .bold()
                }
                Spacer()
                HStack {
                    ForEach(scan.foundAllergensArray, id: \.self) { allergen in
                        Text(AllergenTypes(rawValue: allergen.wrappedType)!.emoji)
                    }
                }
                
            }
            .padding()
    }
}

struct ScanRow_Previews: PreviewProvider {
    static var previews: some View {
        //ScanRow(scan: Scan(dateScanned: Date(), productName: "Popcorn", ingredients: "Corn, Sunflower Oil, Sea Salt, Palm Oil", foundAllergens: [Allergen(name: "Wheat", type: .shellfish, isSelected: true)]))
        Text("a")
    }
}
