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
                        
                        
                        Section(header: Text("Notifications")) {
                            NavigationLink(destination: NotificationsDetailView()) {
                                HStack {
                                    Image(systemName: "bell")
                                        .imageScale(.large)
                                        .foregroundColor(Color.accent)
                                    Text("Options")
                                        .foregroundColor(Color.text)
                                }
                            }
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
