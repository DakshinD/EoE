//
//  BarChartView.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/24/20.
//

import SwiftUI
import Foundation

struct BarChartView: View {
    
    var symptomsPerDay: [String : Int] = ["Sun":2, "Mon":4, "Tue":1, "Wed":2, "Thu":3, "Fri":2, "Sat":5]
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.secondary)
                    .frame(height: 210)
                
                HStack {
                    ForEach(Calendar.autoupdatingCurrent.shortWeekdaySymbols, id: \.self) { day in
                        VStack {
                            
                            Spacer()
                            
                            Text("\(symptomsPerDay[day]!)")
                                .foregroundColor(Color.text)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                            
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.accent, Color.accentSecondary]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 25, height: CGFloat((190/(symptomsPerDay.values.max()!+2)))*CGFloat(symptomsPerDay[day]!))
                            
                            Text(day)
                                .foregroundColor(Color.text)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                        }
                        .padding(.vertical)
                    }
                }
                
            }
            .frame(height: 210)
            
        }
        
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}
