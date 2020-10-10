//
//  Scan+CoreDataProperties.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/7/20.
//
//

import Foundation
import CoreData


extension Scan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scan> {
        return NSFetchRequest<Scan>(entityName: "Scan")
    }

    @NSManaged public var dateScanned: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var ingredients: String?
    @NSManaged public var productName: String?
    @NSManaged public var foundAllergens: NSSet?
    @NSManaged public var nutrients: NSSet?
    
    public var wrappedProductName: String {
        productName ?? "Unkown product"
    }
    
    public var wrappedIngredients: String {
        ingredients ?? "Ingredients not available"
    }
    
    public var wrappedDate: Date {
        dateScanned ?? Date() // Fix this to show no date
    }
    
    public var foundAllergensArray: [ScannedAllergen] {
        let set = foundAllergens as? Set<ScannedAllergen> ?? []
        return set.sorted {
            $0.name ?? "Unkown Allergen" < $1.name ?? "Unkown Allergen"
        }
    }
    
    public var nutrientsArray: [Nutrient] {
        let set = nutrients as? Set<Nutrient> ?? []
        return set.sorted {
            $0.nutrientName ?? "Unknown nutrient" < $1.nutrientName ?? "Unknown Allergen"
        }
    }

}

// MARK: Generated accessors for foundAllergens
extension Scan {

    @objc(addFoundAllergensObject:)
    @NSManaged public func addToFoundAllergens(_ value: ScannedAllergen)

    @objc(removeFoundAllergensObject:)
    @NSManaged public func removeFromFoundAllergens(_ value: ScannedAllergen)

    @objc(addFoundAllergens:)
    @NSManaged public func addToFoundAllergens(_ values: NSSet)

    @objc(removeFoundAllergens:)
    @NSManaged public func removeFromFoundAllergens(_ values: NSSet)

}

// MARK: Generated accessors for nutrients
extension Scan {

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: Nutrient)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: Nutrient)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)

}

extension Scan : Identifiable {

}
