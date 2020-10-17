//
//  DiaryItemRow.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/17/20.
//

import SwiftUI

struct DiaryItemRow: View {
    
    var item: DiaryItem
    
    var body: some View {
        HStack(spacing: 15) {
            Text(correctEmoji())
            VStack(alignment: .leading) {
                Text(item.wrappedTitle)
                    .foregroundColor(.white)
                    .font(.body)
                Text(item.wrappedTime, style: .time)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
    
    func correctEmoji() -> String {
        switch item.type {
        case "Meal":
            return "🍽"
        case "Drink":
            return "🥤"
        case "Symptom":
            return "🤒"
        case "Medicine":
            return "💊"
        default:
            return ""
        }
    }
}

struct DiaryItemRow_Previews: PreviewProvider {
    static var previews: some View {
        //DiaryItemRow()
        EmptyView()
    }
}
