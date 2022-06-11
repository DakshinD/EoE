//
//  SymptomDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/24/20.
//

import SwiftUI

struct SymptomAnalysisDetailView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var stats: Statistics
    
    var symptomType: String
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    List {
                        
                        Section(header: Text("General")) {
                            HStack {
                                Text("Number of Times")
                                    .foregroundColor(.text)
                                Spacer()
                                Text("\(stats.numOfSymptom[symptomType] ?? 0)") // check this optional
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Most likely Ingredient Trigger")
                                    .foregroundColor(.text)
                                Spacer()
                                Text((possibleIngredientTriggers.count == 0) ? "N/A" : possibleIngredientTriggers[0])
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Most likely Meal Trigger")
                                    .foregroundColor(.text)
                                Spacer()
                                Text((possibleMealTriggers.count == 0) ? "N/A" : possibleMealTriggers[0])
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Section(header: Text("Possible Ingredient Triggers")) {
                            if possibleIngredientTriggers.count == 0 {
                                Text("There doesn't seem to be any possible triggers for this symptom so far")
                                    .foregroundColor(.text)
                                    .padding()
                            } else {
                                ForEach(possibleIngredientTriggers, id: \.self) { trigger in
                                    HStack {
                                        Text(trigger)
                                            .foregroundColor(.text)
                                        Spacer()
                                        Text("\(stats.triggers[symptomType]![trigger]!)") // check these optionals
                                            .foregroundColor(.gray)
                                        (stats.triggers[symptomType]![trigger]!==1) ? Text("time").foregroundColor(.gray) : Text("times").foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Possible Meal Triggers")) {
                            if possibleMealTriggers.count == 0 {
                                Text("There doesn't seem to be any possible triggers for this symptom so far")
                                    .foregroundColor(.text)
                                    .padding()
                            } else {
                                ForEach(possibleMealTriggers, id: \.self) { trigger in
                                    HStack {
                                        Text(trigger)
                                            .foregroundColor(.text)
                                        Spacer()
                                        Text("\(stats.mealTriggers[symptomType]![trigger]!)") // check these optionals
                                            .foregroundColor(.gray)
                                        (stats.mealTriggers[symptomType]![trigger]!==1) ? Text("time").foregroundColor(.gray) : Text("times").foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                }
                
            }
            .navigationTitle(symptomType)
            
        }
    }
    
    var possibleIngredientTriggers: [String] {
        var possTriggers: [String] = [String]()
        for (trigger, _) in stats.triggers[symptomType] ?? [String : Int]() { // check this optional
            possTriggers.append(trigger)
        }
        possTriggers.sort(by: { stats.triggers[symptomType]![$0]! > stats.triggers[symptomType]![$1]! }) // check these optionals
        return possTriggers
    }
    
    var possibleMealTriggers: [String] {
        var possMealTriggers: [String] = [String]()
        for (trigger, _) in stats.mealTriggers[symptomType] ?? [String : Int]() { // check this optional
            possMealTriggers.append(trigger)
        }
        possMealTriggers.sort(by: { stats.mealTriggers[symptomType]![$0]! > stats.mealTriggers[symptomType]![$1]! }) // check these optionals
        return possMealTriggers
    }
    
}

struct SymptomAnalysisDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomAnalysisDetailView(symptomType: "Flare-Up")
    }
}
