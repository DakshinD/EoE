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
    
    @Published(key: "notificationsEnabled")
    var notificationsEnabled: Bool = false
    
    @Published(key: "darkMode")
    var darkMode: Bool = false

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

