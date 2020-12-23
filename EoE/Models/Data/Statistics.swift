//
//  Statistics.swift
//  EoE
//
//  Created by Dakshin Devanand on 11/30/20.
//

import SwiftUI

class Statistics: ObservableObject {
    
    @Published(key: "numOfSymptom")
    var numOfSymptom: [String : Int] = [String:Int]()
    
    @Published(key: "numOfMeal")
    var numOfMeal: [String : Int] = [String:Int]()
    
    @Published(key: "triggers")
    var triggers: [String : [String : Int]] = [String:[String:Int]]()
    
    func generateStats() {
        // do stuff
    }
    
    
}
