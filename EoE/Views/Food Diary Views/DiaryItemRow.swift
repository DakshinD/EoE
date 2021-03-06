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
                
                if item.type != "Symptom" && item.type != "Medicine" {
                    Text(item.wrappedTitle)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
                
                if item.type == "Meal"  {
                    Text(item.wrappedMealType)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                if item.type == "Symptom" {
                    Text(item.wrappedSymptomType)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
                
                if item.type == "Medicine" {
                    Text(item.wrappedMedicineType)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
            }
            Spacer()
            Text(item.wrappedTime, style: .time)
                .font(.system(size: 15, weight: .light, design: .rounded))
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
    
    func correctColor() -> Color {
        switch item.type {
        case "Meal":
            return Color("darkPurple")
        case "Drink":
            return Color.blue
        case "Symptom":
            return Color.red
        case "Medicine":
            return Color.green
        default:
            return Color.orange
        }
    }
}

struct PastDiaryItemRow: View {
    
    var item: DiaryItem
        
    var body: some View {
        HStack(spacing: 15) {
            Text(correctEmoji())
            VStack(alignment: .leading) {
                
                if item.type != "Symptom" && item.type != "Medicine" {
                    Text(item.wrappedTitle)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
                
                if item.type == "Meal"  {
                    Text(item.wrappedMealType)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                if item.type == "Symptom" {
                    Text(item.wrappedSymptomType)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
                
                if item.type == "Medicine" {
                    Text(item.wrappedMedicineType)
                        .foregroundColor(Color.text)
                        .font(.body)
                }
            }
            Spacer()
            Text(item.wrappedTime, style: .date)
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundColor(.gray)
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
    
    func correctColor() -> Color {
        switch item.type {
        case "Meal":
            return Color("darkPurple")
        case "Drink":
            return Color.blue
        case "Symptom":
            return Color.red
        case "Medicine":
            return Color.green
        default:
            return Color.orange
        }
    }
}
