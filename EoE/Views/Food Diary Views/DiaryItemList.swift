//
//  DiaryItemList.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/17/20.
//

import SwiftUI

struct DiaryItemList: View {
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    var body: some View {
        Section(header: Text("Diary")) {
            ForEach(fetchRequest.wrappedValue.sorted(by: { $0.wrappedTime < $1.wrappedTime }), id: \.self) { item in
                DiaryItemRow(item: item)
            }
        }
        .listRowBackground(Color("black3"))
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
