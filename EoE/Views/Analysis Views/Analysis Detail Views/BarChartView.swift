//
//  BarChartView.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/24/20.
//

import SwiftUI
import Foundation

struct BarChartView: View {
    
    //@EnvironmentObject var stats: Statistics
    @Binding var symptomsPerDay: [String : Int]
    //var test: [String : Int] = ["Sun":2, "Mon":4, "Tue":1, "Wed":2, "Thu":3, "Fri":2, "Sat":5]
    //var symptomsPerDay: [String : Int]
    
    // add selection option?
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                VStack {
                    
                    HStack {
                        Text("Symptom Frequency")
                            .foregroundColor(.text)
                            .bold()
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    HStack(alignment: .bottom) {
                        ForEach(Calendar.autoupdatingCurrent.shortWeekdaySymbols, id: \.self) { day in
                            VStack {
                                
                                Spacer()
                                                                
                                Text("\(symptomsPerDay[day]!)")
                                    .foregroundColor(Color.text)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                
                                Capsule()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accent, Color.accentSecondary]), startPoint: .top, endPoint: .bottom))
                                    .frame(width: 25, height: CGFloat((160/(symptomsPerDay.values.max()!+2)))*CGFloat(symptomsPerDay[day]!))
                                    .padding(.horizontal, 7)
                                // adapt this for smaller screen sizes
                                
                                Text(day)
                                    .foregroundColor(Color.text)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                            }
                            .padding(.bottom)

                        }
                    }
                    
                }
            }
            .frame(height: 230)
        }
        
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //BarChartView()
    }
}
