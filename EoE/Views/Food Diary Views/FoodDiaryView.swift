//
//  FoodDiaryView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct FoodDiaryView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var currentDateChosen: Date = Date()
    @State private var showingAddItemView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                List {

                    HStack {
                        Text("Chosen Day: ")
                            .foregroundColor(.white)
                        Spacer()
                        DatePicker("", selection: $currentDateChosen, displayedComponents: .date)
                    }
                    .listRowBackground(Color("black3"))
                    
                    DiaryItemList(filter: currentDateChosen)
                        
                }
                .padding(.top)
                .listStyle(InsetGroupedListStyle())
                .animation(.default)
                
                
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
                }
            )
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
