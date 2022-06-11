//
//  AllergenDetection.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import CoreData

struct AllergenDetection {
    
    var managedObjectContext: NSManagedObjectContext
    
    var allergens: [Allergen] = [Allergen]()
    
    init(_ moc: NSManagedObjectContext) {
        managedObjectContext = moc
        fetchAllergens()
    }
    
    mutating func fetchAllergens() {
        let request: NSFetchRequest<Allergen> = Allergen.fetchRequest()
        
        do {
            allergens = try managedObjectContext.fetch(request)
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
        }
    }
    
    func detectAllergens(scan: Scan) -> [ScannedAllergen] {
        var foundAllergens: [ScannedAllergen] = [ScannedAllergen]()
        allergens.forEach { (allergen) in
            if allergen.isSelected {
                if checkForAllergen(allergen: allergen, ingredientsText: scan.wrappedIngredients) {
                    let scannedAllergen = ScannedAllergen(context: managedObjectContext)
                    scannedAllergen.name = allergen.name
                    scannedAllergen.type = allergen.type
                    scannedAllergen.scan = scan
                                        
                    foundAllergens.append(scannedAllergen)
                    
                    do { // is it necessary to save this frequently?
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        return foundAllergens
    }
    
    func detectAllergensInIngredientsList(ingredients: String) -> [String] {
        var foundAllergens: [String] = [String]()
        allergens.forEach { allergen in
            if allergen.isSelected && AllergenTypes(rawValue: allergen.type!) != AllergenTypes.userCreated {
                if checkForAllergen(allergen: allergen, ingredientsText: ingredients) {
                    foundAllergens.append(allergen.type ?? "Unkown Type")
                }
            }
        }
        return foundAllergens
    }
    
    func detectUserCreatedAllergensInIngredientsList(ingredients: String) -> [String] {
        var foundUserCreatedAllergens: [String] = [String]()
        allergens.forEach { allergen in
            if allergen.isSelected && AllergenTypes(rawValue: allergen.type!) == AllergenTypes.userCreated {
                if checkForAllergen(allergen: allergen, ingredientsText: ingredients) {
                    foundUserCreatedAllergens.append(allergen.name!)
                }
            }
        }
        return foundUserCreatedAllergens
    }
    
    func checkForAllergen(allergen: Allergen, ingredientsText: String) -> Bool {
        if AllergenTypes(rawValue: allergen.type!) != AllergenTypes.userCreated {
            for allergenName in AllergenTypes(rawValue: allergen.type!)!.items {
                if ingredientsText.contains(allergenName.uppercased()) {
                    return true
                }
            }
        } else { // check for user created allergen
            if ingredientsText.contains((allergen.name?.uppercased())!) { // forced optional - check
                return true
            }
        }
        return false
    }
}


