//
//  SettingsView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.background
                        .edgesIgnoringSafeArea(.all)
                    
                    List {
                        
                        Section(header: Text("Allergens")) {
                            NavigationLink(destination: AllergenSelectionView()) {
                                HStack {
                                    Image(systemName: "cross.case")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Select Allergens")
                                        .foregroundColor(Color.text)
                                    Spacer()
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Food Diary Options")) {
                            NavigationLink(destination: MedicineOptionView()) {
                                HStack {
                                    Image(systemName: "pills")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Medications")
                                        .foregroundColor(Color.text)
                                    Spacer()
                                }
                            }
                            NavigationLink(destination: SymptomOptionView()) {
                                HStack {
                                    Image(systemName: "bolt.heart")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                        
                                    Text("Symptoms")
                                        .foregroundColor(Color.text)
                                    Spacer()
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        
                        Section(header: Text("Notifications"), footer: Text("Reminders at the times you choose to add what you ate into your food diary").padding(.bottom)) {
                            
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
                        
                        Section(header: Text("Appearance")) {
                            Toggle(isOn: $userData.darkMode) {
                                HStack {
                                    Image(systemName: "circle.lefthalf.fill")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Dark Mode")
                                        .foregroundColor(Color.text)
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("App"), footer:
                                    HStack {
                                        Spacer()
                                        Text("EoE v1.0.0") //UIApplication.appVersion ??
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                        Spacer()
                                    }
                        ) {
                            
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "star")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Rate the App")
                                        .foregroundColor(Color.text)
                                }
                            }
                            
                        }
                        .listRowBackground(Color.secondary)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .animation(.default)
                    
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserData())
    }
}
