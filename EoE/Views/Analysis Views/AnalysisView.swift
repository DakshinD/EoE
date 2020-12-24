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
                                
                                Section(header: Text("Most Frequent Symptom")) {
                                    Text(getMostFrequentSymptom())
                                        .foregroundColor(Color.text)
                                }
                                                        
                            }
                            .listStyle(InsetGroupedListStyle())
                            
                            Spacer()
                                                    
                        }
                                        
                }
                .navigationTitle("Analytics")
                
            }
        }
        
    }
    
    func getMostFrequentSymptom() -> String {
        print("here")
        var symptom: String = "a"
        var count: Int = 0
        for (symp, cnt) in stats.numOfSymptom {
            if cnt > count {
                symptom = symp
                count = cnt
            }
        }
        print(symptom)
        return symptom
    }

}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
            .environmentObject(UserData())
    }
}
