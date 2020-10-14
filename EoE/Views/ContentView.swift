//
//  ContentView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var scanningProcess: ScanningProcess

    
    @State private var barcodeButtonShown: Bool = false
    @State private var ingredientsButtonShown: Bool = false

    
    
    var body: some View {
        TabView {
            
            ScanView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("Scan")
                }
    
            FoodDiaryView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Food Diary")
                }
            
            AnalysisView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Analysis")
                }
            
            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        }
        .accentColor(Color("darkPurple"))
        
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
            .environmentObject(ScanningProcess())

    }
}
