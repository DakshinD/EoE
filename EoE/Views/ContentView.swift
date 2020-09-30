//
//  ContentView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var buttonShown: Bool = false
    
    var body: some View {
        TabView {
            
            ScanView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("Scan")
                }
                .overlay(
                    GeometryReader { geo in
                            ZStack {
                                ZStack {
                                    Button(action: {
                                        withAnimation {
                                            buttonShown.toggle()
                                        }
                                    }) {
                                            FloatingScanButton()
                                    }
                                    
                                    if buttonShown {
                                        BarcodeScanButton()
                                        IngredientsScanButton()
                                    }
                                    
                                }
                            }
                            .padding(.trailing, 25)
                            .padding(.bottom, 35)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
                    }
                        
                )
    
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
    }
}
