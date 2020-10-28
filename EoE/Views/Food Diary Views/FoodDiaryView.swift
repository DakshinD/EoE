//
//  FoodDiaryView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct FoodDiaryView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var userData: UserData
    
    @State var currentDateChosen: Date = Date()
    @State private var showingAddItemView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Current Day:")
                            .foregroundColor(.white)
                        Spacer()
                        DatePicker("", selection: $currentDateChosen, displayedComponents: .date)
                    }
                    
                    DiaryItemList(filter: currentDateChosen)
                }
                .listStyle(InsetGroupedListStyle())
                .animation(.default)
                .padding(.top)
                
                
            }
            .navigationTitle("Food Diary")
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddItemView.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                }
                .sheet(isPresented: $showingAddItemView) {
                    AddDiaryItemView(chosenDate: currentDateChosen)
                        .environmentObject(userData)
                })
        }
    }
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
}

struct FoodDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDiaryView()
    }
}
