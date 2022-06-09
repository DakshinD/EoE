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
    @EnvironmentObject var stats: Statistics
    
    @State var currentDateChosen: Date = Date()
    @State private var showingAddItemView: Bool = false
    @State private var modeChosen: Int = 0
    
    var modes: [String] = ["Day", "Week"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Picker(selection: $modeChosen, label: Text("Diary Entries")) {
                        ForEach(0..<modes.count, id:\.self) { index in
                            Text(modes[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    List {
                        if modeChosen == 0 {
                            HStack {
                                Image(systemName: "calendar")
                                    .imageScale(.large)
                                    .foregroundColor(Color.accent)
                                Text("Current Day:")
                                    .foregroundColor(Color.text)
                                Spacer()
                                DatePicker("", selection: $currentDateChosen, displayedComponents: .date)
                            }
                            //.animation(.default)
                        }
                        
                        getListView(mode: modeChosen)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    //.animation(.default)
                }
                .padding(.top)
                
                
            }
            .navigationTitle("Food Diary")
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddItemView.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding()
                }
                .sheet(isPresented: $showingAddItemView) {
                    AddDiaryItemView(chosenDate: currentDateChosen)
                        .environmentObject(userData)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                })
        }
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    func getListView(mode: Int) -> AnyView {
        switch mode {
        case 0:
            return AnyView(DiaryItemDayList(chosenPredicate: getPredicate(filter: currentDateChosen, mode: mode)))
        case 1:
            return AnyView(DiaryItemWeekList(dayToItems: stats.sortItemsByDay()))
        default:
            return AnyView(Text("Something went wrong"))
        }
    }
    
    func getPredicate(filter: Date, mode: Int) -> NSPredicate {
        switch mode {
        case 0:
            return filter.makeDayPredicate()
        case 1:
            return filter.makeWeekPredicate()
        default:
            return filter.makeDayPredicate()
        }
    }
    
}

struct FoodDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDiaryView()
    }
}
