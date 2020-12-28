//
//  NotificationManager.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/28/20.
//

import UIKit
import UserNotifications

class NotificationManager {
    
    static func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        print("Notification authorization success")
                    } else {
                        print("Notification authorization denied")
                    }
                }
            }
        }
    }
    
    static func scheduleNotification(time: Date, meal: Meals) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Food Diary Reminder"
        content.body = "Remember to add what you ate for \(meal) into your food diary!"
        content.sound = UNNotificationSound.default
        
        let date = Calendar.current.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let identifier: String = meal.rawValue
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Could not add notification")
            } else {
                print("Notification added successfully")
            }
        }
    }
    
    static func removeSpecificNotification(meal: Meals) {
        let center = UNUserNotificationCenter.current()
        
        center.removeDeliveredNotifications(withIdentifiers: [meal.rawValue])
    }
    
    static func removeNotifications() {
        let center = UNUserNotificationCenter.current()

        center.removeAllPendingNotificationRequests()
    }
    
}

enum Meals: String {
    case breakfast
    case lunch
    case dinner
}
