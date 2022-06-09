//
//  AnalysisView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct AnalysisView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var stats: Statistics
    
    var body: some View {

        NavigationView {
                
            GeometryReader { geo in
                
                ZStack {
                    
                    Color.background
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                                                
                        List {
                            
                            BarChartView(symptomsPerDay: stats.getSymptomsForWeek())
                                .frame(height: 230)
                            
                            Section(header: Text("Most Frequent Symptom")) {
                                Text(mostFrequentSymptom)
                                    .foregroundColor(Color.text)
                            }
                            
                            Section(header: Text("All Symptoms")) {
                                ForEach(userData.symptomOptions, id: \.self) { symptom in
                                    NavigationLink(destination: SymptomAnalysisDetailView(symptomType: symptom)) {
                                        Text(symptom)
                                            .foregroundColor(.text)
                                            .font(.body)
                                    }
                                }
                            }
                                                    
                        }
                        .listStyle(InsetGroupedListStyle())
                        
                        Spacer()
                                                
                    }
                    .padding(.top)
                }
                .navigationTitle("Analytics")
                .navigationBarItems(trailing:
                    Button(action: {
                        stats.generateStats()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.accent)
                            .imageScale(.medium)
                    })
            }
        }
        
    }
    
    var mostFrequentSymptom: String {
        var symptom: String = "N/A"
        var count: Int = 0
        for (symp, cnt) in stats.numOfSymptom {
            if cnt > count {
                symptom = symp
                count = cnt
            }
        }
        return symptom
    }

}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
            .environmentObject(UserData())
    }
}
