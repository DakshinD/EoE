//
//  DiaryItemSearchView.swift
//  EoE
//
//  Created by Dakshin Devanand on 2/22/21.
//

import SwiftUI

struct DiaryItemSearchView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(
        entity: DiaryItem.entity(),
        sortDescriptors: []
    ) var pastItems: FetchedResults<DiaryItem>
    
    @State private var searchText: String = ""
    @Binding var pastItemChosen: DiaryItem?
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    SearchBar(text: $searchText)
                    
                    List {
                        
                        Section {
                            ForEach(pastItems.filter({ searchText.isEmpty ? true : $0.wrappedTitle.lowercased().contains(searchText.lowercased()) }).sorted { $0.wrappedDate > $1.wrappedDate}, id: \.id) { item in
                                Button(action: {
                                    print("tapped: \(item.wrappedTitle)")
                                    pastItemChosen = item
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    PastDiaryItemRow(item: item)
                                }
                            }
                        }
                        .listRowBackground(Color.secondary)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .animation(.default)
                }
            }
            .navigationTitle("Diary Item Search")
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                            .padding()
                                            .foregroundColor(Color.accent)
                                    }
            )
        }
    }
}

struct DiaryItemSearchView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
