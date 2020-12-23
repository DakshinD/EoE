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
                        
                        Section(header: Text("Allergens").bold()) {
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
                        
                        Section(header: Text("Food Diary Options").bold()) {
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
                        
                        Section(header: Text("Notifications").bold()) {
                            Toggle(isOn: $userData.notificationsEnabled) {
                                HStack {
                                    Image(systemName: "bell")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Enable Notifications")
                                        .foregroundColor(Color.text)
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                        Section(header: Text("Appearance").bold()) {
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
                        
                        Section(header: Text("App").bold(), footer:
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
