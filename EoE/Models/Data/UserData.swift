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
    
    @Published(key: "firstRun")
    var firstRun: Bool = true
    
    @Published(key: "isOnboardingCompleted")
    var isOnboardingCompleted: Bool = false
    
    @Published(key: "isSetupCompleted")
    var isSetupCompleted: Bool = false
    
    @Published(key: "notificationsEnabled")
    var notificationsEnabled: Bool = false
    
    @Published(key: "darkMode")
    var darkMode: Bool = false
    
    @Published var selectedAllergens: [Allergen] = [Allergen]()
    
    @Published var allAllergens: [Allergen] = [Allergen]()
    
    @Published var pastScans: [Scan] = [Scan]()
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

