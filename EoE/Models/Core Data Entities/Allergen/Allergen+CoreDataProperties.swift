//
//  Allergen+CoreDataProperties.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/1/20.
//
//

import Foundation
import CoreData


extension Allergen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Allergen> {
        return NSFetchRequest<Allergen>(entityName: "Allergen")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String?
    @NSManaged public var type: String?

}

extension Allergen : Identifiable {

}
