//
//  DrinkDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/19/20.
//

import SwiftUI

struct DrinkDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section(header: Text("Description")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Type")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedType)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Date")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedDate, style: .date)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Time")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedTime, style: .time)
                    }
                    .foregroundColor(.white)
                }
                .listRowBackground(Color("black3"))
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
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
