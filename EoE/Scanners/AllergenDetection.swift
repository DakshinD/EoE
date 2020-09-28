//
//  AllergenDetection.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct AllergenDetection {
    
    var selectedAllergens: [Allergen]
    
    func detectAllergens(ingredientsText: String) -> [Allergen] {

        var spottedAllergens = [Allergen]()
        for allergen in selectedAllergens {
            if allergen.isSelected {
                if checkForAllergen(allergen: allergen, ingredientsText: ingredientsText) {
                    spottedAllergens.append(allergen)
                }
            }
        }
        return spottedAllergens
    }
    
    func checkForAllergen(allergen: Allergen, ingredientsText: String) -> Bool {
        for allergenName in allergen.type.items {
            if ingredientsText.contains(allergenName.uppercased()) {
                return true
            }
        }
        return false
    }
}
