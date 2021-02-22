//
//  NotificationsDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 2/22/21.
//

import SwiftUI

struct NotificationsDetailView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        GeometryReader { geo in
                ZStack {
                    
                    Color.background
                        .edgesIgnoringSafeArea(.all)
                    
                    List {
                        
                        Section {
                            Toggle(isOn: $userData.notificationsEnabled) {
                                HStack {
                                    Image(systemName: "bell")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Notifications Enabled")
                                        .foregroundColor(Color.text)
                                }
                            }
                            .onChange(of: userData.notificationsEnabled) { (value) in
                                if userData.notificationsEnabled == true {
                                    NotificationManager.requestPermission()
                                    NotificationManager.scheduleNotification(time: userData.breakfastNotification, meal: Meals.breakfast)
                                    NotificationManager.scheduleNotification(time: userData.lunchNotification, meal: Meals.lunch)
                                    NotificationManager.scheduleNotification(time: userData.dinnerNotification, meal: Meals.dinner)
                                } else {
                                    NotificationManager.removeNotifications()
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(footer: Text(userData.notificationsEnabled ? "Reminders at the times you choose to add what you ate into your food diary" : "").padding(.bottom)) {
                            if userData.notificationsEnabled {
                                DatePicker("Breakfast", selection: $userData.breakfastNotification, displayedComponents: .hourAndMinute)
                                    .onChange(of: userData.breakfastNotification) { (value) in
                                        NotificationManager.removeSpecificNotification(meal: Meals.breakfast)
                                        NotificationManager.scheduleNotification(time: userData.breakfastNotification, meal: Meals.breakfast)
                                    }
                                DatePicker("Lunch", selection: $userData.lunchNotification, displayedComponents: .hourAndMinute)
                                    .onChange(of: userData.lunchNotification) { (value) in
                                        NotificationManager.removeSpecificNotification(meal: Meals.lunch)
                                        NotificationManager.scheduleNotification(time: userData.lunchNotification, meal: Meals.lunch)
                                    }
                                DatePicker("Dinner", selection: $userData.dinnerNotification, displayedComponents: .hourAndMinute)
                                    .onChange(of: userData.dinnerNotification) { (value) in
                                        NotificationManager.removeSpecificNotification(meal: Meals.dinner)
                                        NotificationManager.scheduleNotification(time: userData.dinnerNotification, meal: Meals.dinner)
                                    }
                            } // Notification Times
                            
                        }
                        .listRowBackground(Color.secondary)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .animation(.default)
                    .padding(.top)
      
                }
        }
        .navigationTitle(Text("Notifications"))
    }
}

struct NotificationsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsDetailView()
    }
}
