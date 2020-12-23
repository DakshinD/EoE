//
//  MedicineDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/19/20.
//

import SwiftUI

struct MedicineDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    var body: some View {
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section(header: Text("Description")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Type")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedType)
                    }
                    .foregroundColor(Color.text)
                    HStack {
                        Image(systemName: "calendar")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Date")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedDate, style: .date)
                    }
                    .foregroundColor(Color.text)
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Time")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedTime, style: .time)
                    }
                    .foregroundColor(Color.text)
                    HStack {
                        Image(systemName: "pills")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Dosage")
                        Spacer()
                        Text("TBD")
                    }
                    .foregroundColor(Color.text)
                }
                .listRowBackground(Color.secondary)
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.vertical)
        }
        .navigationTitle(fetchRequest.wrappedValue[0].wrappedTitle)
    }
    
    init(itemID: UUID) {
        fetchRequest = FetchRequest(
            entity: DiaryItem.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "id == %@", itemID as CVarArg)
        )
    }
    
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
