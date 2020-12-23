//
//  DiaryItemList.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/17/20.
//

import SwiftUI

struct DiaryItemList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    var body: some View {
        Section(header: Text("Diary")) {
            if fetchRequest.wrappedValue.isEmpty {
                HStack {
                    Text("There are no diary entries for this day!")
                        .foregroundColor(Color.text)
                    Spacer()
                }
            } else {
                ForEach(fetchRequest.wrappedValue.sorted(by: { $0.wrappedTime < $1.wrappedTime }), id: \.id) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        DiaryItemRow(item: item)
                    }
                }
                .onDelete(perform: deleteEntry)
            }
        }
        .listRowBackground(Color.secondary)
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
    
    func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = fetchRequest.wrappedValue[index]
            managedObjectContext.delete(entry)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    init(filter: Date) {
        fetchRequest = FetchRequest(
            entity: DiaryItem.entity(),
            sortDescriptors: [],
            predicate: filter.makeDayPredicate()
        )
    }
}

struct DiaryItemList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //DiaryItemList()
    }
}
