//
//  SymptomOptionView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/21/20.
//

import SwiftUI

struct SymptomOptionView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State private var showAlert: Bool = false
    @State private var symptomText: String = ""
    
    var body: some View {
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Add your common symptoms beforehand for more efficient usage of the Food Diary")
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding()
                
                List {
                    Section(header:
                                HStack {
                                    Text("Symptoms")
                                    Spacer()
                                    Button(action: {
                                        // show alert to let user add new symptom
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(Color.accent)
                                    }
                                }
                    ) {
                        ForEach(userData.symptomOptions, id: \.self) { symptom in
                            HStack {
                                Text(symptom)
                                    .foregroundColor(Color.text)
                                Spacer()
                            }
                        }
                        .onDelete(perform: deleteSymptom)
                    }
                    .listRowBackground(Color.secondary)
                }
                .listStyle(InsetGroupedListStyle())
                
            }
            
            if showAlert {
                AltAlertControlView(textString: $symptomText, showAlert: $showAlert, title: "New Symptom", message: "Type in the name of your symptom", currentOptions: $userData.symptomOptions)
            }
            
        }
        .navigationTitle("Symptom Types")
    }
    
    func deleteSymptom(at offsets: IndexSet) {
        userData.symptomOptions.remove(atOffsets: offsets)
    }
    
}

struct SymptomOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomOptionView()
    }
}
