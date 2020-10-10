//
//  Nutrient+CoreDataProperties.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/7/20.
//
//

import Foundation
import CoreData


extension Nutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrient> {
        return NSFetchRequest<Nutrient>(entityName: "Nutrient")
    }

    @NSManaged public var nutrientName: String?
    @NSManaged public var unitName: String?
    @NSManaged public var derivationDescription: String?
    @NSManaged public var value: Float
    @NSManaged public var id: UUID?
    @NSManaged public var scan: Scan?
    
    public var wrappedNutrientName: String {
        nutrientName ?? "Unkown product"
    }
    
    public var wrappedUnitName: String {
        unitName ?? "Unkown product"
    }
    
    public var wrappedDerivationDescription: String {
        derivationDescription ?? "Unkown derivation description"
    }



}

extension Nutrient : Identifiable {

}
