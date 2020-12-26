//
//  DiaryItemWeekList.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/25/20.
//

import SwiftUI

struct DiaryItemWeekList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var stats: Statistics
                
    var dayToItems: [Date:[DiaryItem]]
    
    var body: some View {
        if dayToItems.isEmpty {
            HStack {
                Text("There are no diary entries for this week!")
                    .foregroundColor(Color.text)
                Spacer()
            }
        } else {
            
            ForEach(Array(dayToItems.keys.sorted(by: >)), id: \.self) { day in
                Section(header: Text("\(Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: day) - 1])")) { // weekday of date
                    ForEach(dayToItems[day]!, id: \.id) { item in // optional
                        DiaryItemRow(item: item)
                    }
                }
                .listRowBackground(Color.secondary)
            }
        }
    }
    
    func DetailView(item: DiaryItem) -> AnyView {
        switch item.wrappedType {
        case "Meal":
            return AnyView(MealDetailView(itemID: item.id!))
        case "Drink":
            return AnyView(DrinkDetailView(itemID: item.id!))
        case "Symptom":
            return AnyView(SymptomDetailView(itemID: item.id!, initalNotes: item.wrappedSymptomDescription))
        case "Medicine":
            return AnyView(MedicineDetailView(itemID: item.id!))
        default:
            return AnyView(Text("Something went wrong"))
        }
    }
    
    init(dayToItems: [Date:[DiaryItem]]) {
        self.dayToItems = dayToItems
    }
}

struct DiaryItemWeekList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //DiaryItemWeekList()
    }
}
