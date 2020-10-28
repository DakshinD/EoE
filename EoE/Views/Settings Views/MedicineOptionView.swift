//
//  MedicineOptionView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/21/20.
//

import SwiftUI

struct MedicineOptionView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State private var showAlert: Bool = false
    @State private var medicineText: String = ""
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Add your different medications beforehand for more efficient usage of the Food Diary")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding()
                
                List {
                    Section(header:
                                HStack {
                                    Text("Medication")
                                    Spacer()
                                    Button(action: {
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(Color("darkPurple"))
                                    }
                                }
                    ) {
                        ForEach(userData.medicineOptions, id: \.self) { medication in
                            HStack {
                                Text(medication)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .onDelete(perform: deleteMedicine)
                    }
                    .listRowBackground(Color("black3"))
                }
                .listStyle(InsetGroupedListStyle())
                
            }
            
            if showAlert {
                AltAlertControlView(textString: $medicineText, showAlert: $showAlert, title: "New Medicine", message: "Type in the name of your medication", currentOptions: $userData.medicineOptions)
            }
            
        }
        .navigationTitle("Medicine Types")
    }
    
    func deleteMedicine(at offsets: IndexSet) {
        userData.medicineOptions.remove(atOffsets: offsets)
    }
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

struct MedicineOptionView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineOptionView()
    }
}
