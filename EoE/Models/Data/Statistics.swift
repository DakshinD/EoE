//
//  Statistics.swift
//  EoE
//
//  Created by Dakshin Devanand on 11/30/20.
//

import SwiftUI
import CoreData
import Foundation

class Statistics: ObservableObject {
    
    var moc: NSManagedObjectContext
    
    var userData: UserData
    
    var items: [DiaryItem] = [DiaryItem]()
    
    init(moc: NSManagedObjectContext, user: UserData) {
        self.moc = moc
        self.userData = user
        self.items = getAllItems()
        generateStats()
    }
    
    //---------------------------------
    
    @Published(key: "numOfSymptom")
    var numOfSymptom: [String : Int] = [String:Int]()
    
    @Published(key: "numOfFood")
    var numOfFood: [String : Int] = [String:Int]()
    
    @Published(key: "triggers")
    var triggers: [String : [String : Int]] = [String:[String:Int]]() // [Symptom : [Ingredient : Num of Occurences]]
    
    @Published(key: "mealTriggers")
    var mealTriggers: [String : [String : Int]] = [String:[String:Int]]() // [Symptom : [Meal : Num of Occurences]]
    
    @Published(key: "symptomsPerDay")
    var symptomsPerDay: [String : Int] = [String : Int]()
    
    func resetAllData() {
        // reset numOfSymptom
        for symptom in userData.symptomOptions {
            numOfSymptom.updateValue(0, forKey: symptom)
        }
        // reset numOfFood
        for (food, _) in numOfFood {
            numOfFood.updateValue(0, forKey: food)
        }
        // reset triggers
        for symptom in userData.symptomOptions {
            triggers.updateValue([String : Int](), forKey: symptom)
        }
        for symptom in userData.symptomOptions {
            mealTriggers.updateValue([String : Int](), forKey: symptom)
        }
        // reset symptoms calculation for bar graph
        symptomsPerDay = getSymptomsForWeek()
    }
    
    //----------------------------------
    
    func generateStats() {
        //reset all values in dictionaries
        resetAllData()
        
        items = getAllItems() // re-fetch diary items
        
        getTriggers()
        
        countNumOfItems()
        
        
    }
    
    func getSymptomsForWeek() -> [String : Int] {
        // fill dictionary with weeks first
        var numSymptoms: [String : Int] = [String:Int]()
        for day in Calendar.autoupdatingCurrent.shortWeekdaySymbols {
            numSymptoms.updateValue(0, forKey: day)
        }
        // get symptom items from this week
        let itemsFromCurrentWeek: [DiaryItem] = getThisWeeksItems()
        let weekSymptoms: [DiaryItem] = itemsFromCurrentWeek.filter { $0.wrappedType == "Symptom" }
        for symptom in weekSymptoms {
            let weekday = Calendar.current.shortWeekdaySymbols[(Calendar.current.component(.weekday, from: symptom.wrappedDate))-1]
            numSymptoms[weekday]! += 1 // optional check
        }
        return numSymptoms
    }
    
    func getTriggers() {
        var sortedItems: [DiaryItem] = items.filter { $0.type != "Medicine" }
        sortedItems.sort(by: {
            if $0.wrappedDate == $1.wrappedDate {
                return $0.wrappedTime < $1.wrappedTime
            } else {
                return $0.wrappedDate < $1.wrappedDate
            }
        })
        
        /*for item in sortedItems {
            item.wrappedType == "Symptom" ? print(item.wrappedSymptomType) : print(item.wrappedTitle)
        }*/
        
        // Check which food item comes before a symptom
        // Fill out triggers dictionary for that symptom with
        // the ingredients and/or food that corresponds
        
        for (index, item) in sortedItems.enumerated() {
            if index != 0 && item.wrappedType == "Symptom" { // We have found a symptom
                if sortedItems[index-1].wrappedType == "Meal" || sortedItems[index-1].wrappedType == "Drink" { // check if prior item is a food
                    let triggerFood = sortedItems[index-1] // Food eaten prior to symptom
                    // Cases:
                    // 1. 0 ingredients - title is what counts
                    // 2. >0 ingredients - title + individual ingredients count
                    // count ingredients
                    if triggerFood.wrappedIngredients.count > 0 {
                        for triggerIngredient in triggerFood.wrappedIngredients {
                            if triggers[item.wrappedSymptomType]?[triggerIngredient] == nil {
                                triggers[item.wrappedSymptomType]?.updateValue(1, forKey: triggerIngredient)
                                //print(triggers[item.wrappedSymptomType]![triggerIngredient]!)
                            } else {
                                triggers[item.wrappedSymptomType]?[triggerIngredient]! += 1
                            }
                        }
                    }
                    // count meal
                    if mealTriggers[item.wrappedSymptomType]?[triggerFood.wrappedTitle] == nil {
                        mealTriggers[item.wrappedSymptomType]?.updateValue(1, forKey: triggerFood.wrappedTitle)
                    } else {
                        mealTriggers[item.wrappedSymptomType]?[triggerFood.wrappedTitle]! += 1
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
                numOfSymptom[item.wrappedSymptomType, default: 0] += 1
            }
        }
    }
    
    func getAllItems() -> [DiaryItem] {
        let fetchRequest: NSFetchRequest<DiaryItem> = DiaryItem.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: true),
            NSSortDescriptor(key: "time", ascending: true)
        ]
        do {
            let items = try moc.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting DiaryItems: \(error.localizedDescription), \(error.userInfo)")
        }
        return [DiaryItem]()
    }
    
    func getThisWeeksItems() -> [DiaryItem] {
        let fetchRequest: NSFetchRequest<DiaryItem> = DiaryItem.fetchRequest()
        fetchRequest.predicate = Date().makeWeekPredicate()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: true),
            NSSortDescriptor(key: "time", ascending: true)
        ]
        do {
            let items = try moc.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting DiaryItems: \(error.localizedDescription), \(error.userInfo)")
        }
        return [DiaryItem]()
    }
    
    func getThisMonthsItems() -> [DiaryItem] {
        let fetchRequest: NSFetchRequest<DiaryItem> = DiaryItem.fetchRequest()
        fetchRequest.predicate = Date().makeMonthPredicate()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: true),
            NSSortDescriptor(key: "time", ascending: true)
        ]
        do {
            let items = try moc.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting DiaryItems: \(error.localizedDescription), \(error.userInfo)")
        }
        return [DiaryItem]()
    }
    
    // Food Diary Methods
    
    func sortItemsByDay() -> [Date:[DiaryItem]] { // for week food diary
        let items: [DiaryItem] = getThisWeeksItems()
        var dayToItems: [Date:[DiaryItem]] = [Date:[DiaryItem]]()
        for item in items {
            let currentDate = Calendar.current.date(from: Calendar.current.dateComponents([.day, .year, .month], from: item.wrappedDate))
            if dayToItems[currentDate!] == nil {
                dayToItems[currentDate!] = []
            }
            //print(currentDate!)
            dayToItems[currentDate!]?.append(item)
            //print(dayToItems[currentDate!]?.count)
        }
        return dayToItems
    }
    
    
    
    
    
    
}
