//
//  SettingsView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct SettingsView: View {
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        // Changes to List
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().separatorColor = UIColor.gray
    }
    
    @State private var notificationsEnabled: Bool = false

    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    List {
                        
                        Section(header: Text("Allergens").bold()) {
                            HStack {
                                Text("Select Allergens")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "chevron.right")
                                        .renderingMode(.template)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("Notifications").bold()) {
                            Toggle(isOn: $notificationsEnabled) {
                                Text("Enable Notifications")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        .listRowBackground(Color("black3"))
                        
                        Section(header: Text("App").bold()) {
                            
                            Button(action: {}) {
                                Text("Rate the App")
                                .foregroundColor(.white)
                                .bold()
                            }
                            
                            HStack {
                                Text("App Version:")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                Text("1.0.0") //UIApplication.appVersion ??
                                    .foregroundColor(.white)
                                    .bold()
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
