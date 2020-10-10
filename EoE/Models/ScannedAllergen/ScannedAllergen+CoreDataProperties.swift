//
//  ScannedAllergen+CoreDataProperties.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/1/20.
//
//

import Foundation
import CoreData


extension ScannedAllergen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScannedAllergen> {
        return NSFetchRequest<ScannedAllergen>(entityName: "ScannedAllergen")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var scan: Scan?
    
    public var wrappedName: String {
        name ?? "Unkown allergen"
    }
    
    public var wrappedType: String {
        type ?? "Unkown allergen type"
    }

}

extension ScannedAllergen : Identifiable {

}
