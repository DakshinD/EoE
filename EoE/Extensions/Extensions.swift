//
//  Extensions.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import UIKit

//NOTE: - App Version

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

//NOTE: - Blur View

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
//NOTE: - String Formatter

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    mutating func trim() {
        self = self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func deletingPrefix(_ prefix: String) {
        guard self.hasPrefix(prefix) else { return }
        self = String(self.dropFirst(prefix.count))
    }
    
    mutating func removeParens() {
        self = self.trimmingCharacters(in: CharacterSet(charactersIn: "()"))
    }
    
    func splitIntoIngredients() -> [String] {
        var str = self.capitalized
        
        var idx = str.firstIndex(of: ":")
        idx = str.index(after: idx ?? str.startIndex)
        str = String(str.suffix(from: idx ?? str.startIndex))
        str.trim()
        var ingredients: [String] = str.components(separatedBy: CharacterSet(charactersIn: ",."))
        var i = 0
        for _ in 0..<ingredients.count {
            ingredients[i].trim()
            ingredients[i].removeParens()
            i+=1
            if i < ingredients.count && ingredients[i].isEmpty {
                ingredients.remove(at: i)
                i-=1
            }
        }
        return ingredients
    }
}

//NOTE: - Decimal Truncation

extension Float {
    func truncate(places: Int) -> Float {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
}

//NOTE: - Custom Button Style

struct CustomButton: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(Color.white)
            .background(configuration.isPressed ? Color.accentSecondary:Color.accent)
            .cornerRadius(25)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.9:1.0)
    }
}

//NOTE: - Date Add-Ons

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var startOfWeek: Date? {
            let gregorian = Calendar(identifier: .gregorian)
            guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
            return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var daysOfWeek: [Date]? {
        guard let startOfWeek = self.startOfWeek else { return nil }
        return (0...6).compactMap{ Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek)}
    }
    
    func makeDayPredicate() -> NSPredicate {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 00
        components.minute = 00
        components.second = 00
        let startDate = calendar.date(from: components)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar.date(from: components)
        let fromPredicate = NSPredicate(format: "date >= %@", startDate! as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", endDate! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        return datePredicate
    }
    
    func makeWeekPredicate() -> NSPredicate {
        let startDate = Date().startOfWeek
        let endDate = Date().endOfWeek
        let fromPredicate = NSPredicate(format: "date >= %@", startDate! as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", endDate! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        return datePredicate
    }
    
    func makeMonthPredicate() -> NSPredicate {
        let startDate = Date().startOfMonth
        let endDate = Date().endOfMonth
        let fromPredicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", endDate as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        return datePredicate
    }
}

//NOTE: - Keyboard Hiding

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
