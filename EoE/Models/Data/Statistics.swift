//
//  Statistics.swift
//  EoE
//
//  Created by Dakshin Devanand on 11/30/20.
//

import SwiftUI
import CoreData

class Statistics: ObservableObject {
    
    var moc: NSManagedObjectContext
    
    var userData: UserData
    
    var items: [DiaryItem] = [DiaryItem]()
    
    //---------------------------------
    
    @Published(key: "numOfSymptom")
    var numOfSymptom: [String : Int] = [String:Int]()
    
    @Published(key: "numOfFood")
    var numOfFood: [String : Int] = [String:Int]()
    
    @Published(key: "triggers")
    var triggers: [String : [String : Int]] = [String:[String:Int]]() // [Symptom : [Food : Num of Occurences]]
    
    //----------------------------------
    
    func resetAllData() {
        // reset numOfSymptom
        for (symptom, _) in numOfSymptom {
            numOfSymptom.updateValue(0, forKey: symptom)
        }
        // reset numOfFood
        for (food, _) in numOfFood {
            numOfFood.updateValue(0, forKey: food)
        }
        // reset triggers
        for(symptom, foods) in triggers {
            for(food, _) in foods {
                triggers[symptom]?.updateValue(0, forKey: food) // check this optional
            }
        }
    }
    
    func generateStats() {
        //reset all values in dictionaries
        resetAllData()
        
        items = getAllItems() // re-fetch diary items
        print(items.count)
        
        getTriggers()
        
        countNumOfItems()
    }
    
    func getTriggers() {
        var sortedItems: [DiaryItem] = items.filter { $0.type != "Medicine" }
        sortedItems.sort(by: { $0.wrappedTime < $1.wrappedTime }) // getting sorted wrong
        for item in sortedItems {
            item.wrappedType == "Symptom" ? print(item.wrappedSymptomType) : print(item.wrappedTitle)
        }
        
        // Check with food item comes before a symptom
        // Fill out triggers dictionary for that symptom with
        // the ingredients and/or food that corresponds
        
        for (index, item) in sortedItems.enumerated() {
            if index != 0 && item.wrappedType == "Symptom" { // We have found a symptom
                if sortedItems[index-1].wrappedType == "Meal" || sortedItems[index-1].wrappedType == "Drink" { // check if prior item is a food
                    let triggerFood = sortedItems[index-1] // Food eaten prior to symptom
                    // Cases:
                    // 1. 0 ingredients - title is what counts
                    // 2. >0 ingredients - individual ingredients are what count
                    if triggerFood.wrappedIngredients.count == 0 {
                        triggers[item.wrappedTitle]?[triggerFood.wrappedTitle, default: 0] +=  1 // check optional
                    } else {
                        for triggerIngredient in triggerFood.wrappedIngredients {
                            triggers[item.wrappedTitle]?[triggerIngredient, default: 0] += 1 // check optional
                        }
                    }
                }
            }
        }
        
        
    }
    
    func countNumOfItems() {
        for item in items {
            if item.type == "Meal" || item.type == "Drink" {
                numOfFood[item.wrappedTitle, default: 0] += 1
            }
            if item.type == "Symptom" {
                numOfSymptom[item.wrappedTitle, default: 0] += 1
            }
        }
    }
    
    init(moc: NSManagedObjectContext, user: UserData) {
        self.moc = moc
        self.userData = user
        self.items = getAllItems()
        generateStats()
    }
    
    func getAllItems() -> [DiaryItem] {
        let fetchRequest: NSFetchRequest<DiaryItem> = DiaryItem.fetchRequest()
        do {
            let items = try moc.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting DiaryItems: \(error.localizedDescription), \(error.userInfo)")
        }
        return [DiaryItem]()
    }
    
    
}
