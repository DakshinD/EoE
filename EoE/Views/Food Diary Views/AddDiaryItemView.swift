//
//  AddDiaryItemView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/16/20.
//

import SwiftUI

struct AddDiaryItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    var dateChosen: Date
    
    @State private var name: String = ""
    @State private var selectedChoice: Int = 2
    @State private var timeChosen: Date = Date()
    var typeChoices: [String] = ["Meal", "Drink", "Symptom", "Medicine"]
    
    @State private var ingredients: [String] = []
    @State private var showAlert: Bool = false
    @State private var ingredientText: String = ""
    
    @State private var symptomDescription: String = ""
    @State private var symptomTypeChosen: Int = 0
    var symptomTypes: [String] = ["Esophageal Flare-up", "Impaction", "Stomach ache"]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Form {
                        
                        Section(header: Text("Item Details")) {
                            // Name
                            TextField("Name", text: $name)
                                .foregroundColor(.white)
                            // Time
                            DatePicker("Time", selection: $timeChosen, displayedComponents: .hourAndMinute)
                                .foregroundColor(.white)
                            // Type
                            Picker("Item Type", selection: $selectedChoice) {
                                ForEach(0 ..< typeChoices.count) {
                                    Text(typeChoices[$0])
                                }
                            }
                            .foregroundColor(.white)
                            
                        }
                        .listRowBackground(Color("black3"))
                        
                        if typeChoices[selectedChoice] == "Meal" {
                            // Ingredients
                            // list where user can freely add and delete items
                            Section(header: HStack {
                                            Text("Ingredients")
                                            Spacer()
                                            Button(action: {
                                                ingredientText = ""
                                                showAlert.toggle()
                                            }) {
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                                    .foregroundColor(Color("darkPurple"))
                                            }
                                        }) {
                                if ingredients.isEmpty {
                                    HStack {
                                        HStack {
                                            Text("Add some ingredients!")
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                    }
                                } else {
                                    ForEach(ingredients, id: \.self) { ingredient in
                                        HStack {
                                            Text(ingredient)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                    }
                                    .onDelete(perform: deleteIngredient)
                                }
                                
                            }
                            .listRowBackground(Color("black3"))
                        }
                        
                        if typeChoices[selectedChoice] == "Symptom" {
                            // Symptom Details
                            Section(header: Text("Symptom Details")) {
                                // Symptom type
                                Picker("Type", selection: $symptomTypeChosen) {
                                    ForEach(0 ..< symptomTypes.count) {
                                        Text(symptomTypes[$0])
                                    }
                                }
                                .foregroundColor(.white)
                                
                                // Description
                                TextField("Symptom description", text: $symptomDescription)
                                    .foregroundColor(.white)
                            }
                            .listRowBackground(Color("black3"))
                        }
                        
                    }
                    .padding()
                    .animation(.default)
                    
                    Button(action: {
                        saveDiaryItem()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    .buttonStyle(PurpleStyle())
                    .frame(width: 300, height: 50)
                    .padding()
                                        
                }
                .ignoresSafeArea(.keyboard)
                
                if showAlert {
                    AlertControlView(textString: $ingredientText, showAlert: $showAlert, ingredients: $ingredients, title: "Add Ingredient", message: "Make sure your spelling is consistent!")
                }
            }
            .navigationTitle("Add Diary Item")
            .navigationBarItems(leading: Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                Image(systemName: "xmark").padding()
                                    } )
        }
        .onTapGesture {
                self.endEditing(true)
        }
    }
    
    func saveDiaryItem() {
        let item = DiaryItem(context: managedObjectContext)
        
        item.title = name
        item.time = timeChosen
        item.date = dateChosen
        item.type = typeChoices[selectedChoice]
        
        if item.wrappedType == "Meal" {
            item.ingredients = ingredients
        }
        
        if item.wrappedType == "Symptom" {
            item.symptomType = symptomTypes[symptomTypeChosen]
            item.symptomDescription = symptomDescription
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func deleteIngredient(at offsets: IndexSet) {
            ingredients.remove(atOffsets: offsets)
        }
    
    init(chosenDate: Date) {
        dateChosen = chosenDate
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        // Changes to List
        UITableView.appearance().backgroundColor = UIColor.black
        UITableView.appearance().tintColor = UIColor(Color("darkPurple"))
        UITableViewCell.appearance().backgroundColor = UIColor(Color("black3"))
        UITableViewCell.appearance().tintColor = UIColor(Color("darkPurple"))
    }
}

struct AddDiaryItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddDiaryItemView(chosenDate: Date())
        }
    }
}
