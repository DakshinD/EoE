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
                Text(scan.productName)
                    .foregroundColor(.white)
                    .bold()
                Text(scan.dateScanned, style: .date)
                    .font(.caption)
                    .foregroundColor(Color("gray1"))
                    .bold()
            }
            Spacer()
            HStack {
                ForEach(scan.foundAllergens) { allergen in
                    ZStack {

                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(allergen.type.color)
                        
                        Text(allergen.type.symbol)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                    }
                }
            }
            
        }
        .padding()
        .background(Color("black3"))
    }
}

struct ScanRow_Previews: PreviewProvider {
    static var previews: some View {
        ScanRow(scan: Scan(dateScanned: Date(), productName: "Popcorn", ingredients: "Corn, Sunflower Oil, Sea Salt, Palm Oil", foundAllergens: [Allergen(name: "Wheat", type: .shellfish, isSelected: true)]))
    }
}
