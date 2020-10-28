//
//  DiaryItem+CoreDataProperties.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/17/20.
//
//

import Foundation
import CoreData


extension DiaryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryItem> {
        return NSFetchRequest<DiaryItem>(entityName: "DiaryItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var time: Date?
    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var symptomDescription: String?
    @NSManaged public var symptomType: String?
    @NSManaged public var mealType: String?
    @NSManaged public var medicineType: String?
    
    public var wrappedTitle: String {
        title ?? "???"
    }
    
    public var wrappedTime: Date {
        time ?? Date()
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
    
    public var day: Int {
        wrappedDate.get(.day)
    }
    
    public var month: Int {
        wrappedDate.get(.month)
    }
    
    public var year: Int {
        wrappedDate.get(.year)
    }
    
    public var wrappedType: String {
        type ?? "Unkown Type"
    }
    
    public var wrappedIngredients: [String] {
        ingredients ?? [String]()
    }
    
    public var wrappedSymptomDescription: String {
        symptomDescription ?? "No description available"
    }
    
    public var wrappedSymptomType: String {
        symptomType ?? "Unkown symptom type"
    }
    
    public var wrappedMealType: String {
        mealType ?? "Unkown meal type"
    }
    
    public var wrappedMedicineType: String {
        medicineType ?? "Unkown medicine type"
    }

}

extension DiaryItem : Identifiable {

}
