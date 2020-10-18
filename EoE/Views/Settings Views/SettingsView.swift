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
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    List {
                        
                        Section(header: Text("Allergens").bold()) {
                            NavigationLink(destination: AllergenSelectionView()) {
                                HStack {
                                    Text("Select Allergens")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Notifications").bold()) {
                            Toggle(isOn: $userData.notificationsEnabled) {
                                Text("Enable Notifications")
                                    .foregroundColor(.white)
                            }
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Appearance").bold()) {
                            
                            Toggle(isOn: $userData.darkMode) {
                                Text("Dark Mode")
                                    .foregroundColor(.white)
                            }
                            
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("App").bold()) {
                            
                            Button(action: {}) {
                                Text("Rate the App")
                                .foregroundColor(.white)
                            }
                            
                            HStack {
                                Text("App Version:")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("1.0.0") //UIApplication.appVersion ??
                                    .foregroundColor(.white)
                            }
                            
                        }
                        .listRowBackground(Color("black3"))
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        // Changes to List
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().separatorColor = UIColor.gray
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserData())
    }
}