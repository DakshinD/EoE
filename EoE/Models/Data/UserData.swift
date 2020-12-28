//
//  UserData.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI
import Foundation
import Combine


class UserData: ObservableObject {
        
    @Published(key: "isNotFirstLaunch")
    var isNotFirstLaunch: Bool = true
    
    @Published(key: "isOnboardingCompleted")
    var isOnboardingCompleted: Bool = false
    
    @Published(key: "isSetupCompleted")
    var isSetupCompleted: Bool = false
    
    @Published(key: "darkMode")
    var darkMode: Bool = false
    
    // Food Diary Settings
    
    @Published(key: "symptomOptions")
    var symptomOptions: [String] = ["Esophageal Flare-Up", "Impaction"]
    
    @Published(key: "medicineOptions")
    var medicineOptions: [String] = ["Budesonide", "Flovent", "Nexium"]
    
    // Notification Settings
    
    @Published(key: "notificationsEnabled")
    var notificationsEnabled: Bool = false
    
    @Published(key: "breakfastNotification")
    var breakfastNotification: Date = Calendar(identifier: .gregorian).date(from: DateComponents(hour: 8, minute: 0, second: 0))!
    
    @Published(key: "lunchNotification")
    var lunchNotification: Date = Calendar(identifier: .gregorian).date(from: DateComponents(hour: 12, minute: 0, second: 0))!
    
    @Published(key: "dinnerNotification")
    var dinnerNotification: Date = Calendar(identifier: .gregorian).date(from: DateComponents(hour: 18, minute: 0, second: 0))!

}

extension Published {
    
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        projectedValue.receive(subscriber: Subscribers.Sink(receiveCompletion: { (_) in
            ()
        }, receiveValue: { (value) in
            UserDefaults.standard.set(value, forKey: key)
        }))
    }
    
}

