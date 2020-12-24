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
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var stats: Statistics
    
    var dateChosen: Date
    
    // Generic Details
    @State private var name: String = ""
    @State private var selectedChoice: Int = 0
    @State private var timeChosen: Date = Date()
    var typeChoices: [String] = ["Meal", "Drink", "Symptom", "Medicine"]
    
    // Meal Specific Details
    @State private var ingredients: [String] = []
    @State private var showAlert: Bool = false
    @State private var ingredientText: String = ""
    @State private var selectedMealType: Int = 0
    var mealChoices: [String] = ["Breakfast", "Lunch", "Dinner", "Snack", "Dessert"]
    
    // Drink Specific Details
    @State private var drinkIngredients: [String] = []
    @State private var showDrinkAlert: Bool = false
    
    // Symptom Specific Details
    @State private var symptomDescription: String = "Notes"
    @State private var symptomTypeChosen: Int = 0
    var symptomTypes: [String] = ["Esophageal Flare-up", "Impaction", "Stomach ache"]
    
    // Medicine Specific Details
    @State private var medicineTypeChosen: Int = 0
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.background
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                            self.endEditing(true)
                    }
                
                VStack {
                    
                    Form {
                        
                        Section(header: Text("Item Details")) {
                            // Name
                            if selectedChoice != 2 && selectedChoice != 3 {
                                TextField("Name", text: $name)
                                    .foregroundColor(Color.text)
                                    .font(.body)
                            }
                            // Time
                            DatePicker("Time", selection: $timeChosen, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color.text)
                                .accentColor(Color.accent)
                                .font(.body)
                            // Type
                            Picker("Item Type", selection: $selectedChoice) {
                                ForEach(0 ..< typeChoices.count) {
                                    Text(typeChoices[$0])
                                        .font(.body)
                                }
                            }
                            .foregroundColor(Color.text)
                            
                            if typeChoices[selectedChoice] == "Meal" {
                                Picker("Meal Type", selection: $selectedMealType) {
                                    ForEach(0 ..< mealChoices.count) {
                                        Text(mealChoices[$0])
                                            .font(.body)
                                    }
                                }
                                .foregroundColor(Color.text)
                            }
                            
                        }
                        .listRowBackground(Color.secondary)
                        
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
                                                    .foregroundColor(Color.accent)
                                            }
                                        }) {
                                // Ingredients table
                                if ingredients.isEmpty {
                                    HStack {
                                        HStack {
                                            Text("Add some ingredients!")
                                                .foregroundColor(Color.text)
                                                .font(.body)
                                            Spacer()
                                        }
                                    }
                                } else {
                                    ForEach(ingredients, id: \.self) { ingredient in
                                        HStack {
                                            Text(ingredient)
                                                .foregroundColor(Color.text)
                                                .font(.body)
                                            Spacer()
                                        }
                                    }
                                    .onDelete(perform: deleteIngredient)
                                }
                                
                            }
                            .listRowBackground(Color.secondary)
                        }
                        
                        if typeChoices[selectedChoice] == "Drink" {
                            Section(header: HStack {
                                            Text("Ingredients")
                                            Spacer()
                                            Button(action: {
                                                ingredientText = ""
                                                showDrinkAlert.toggle()
                                            }) {
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                                    .foregroundColor(Color.accent)
                                            }
                                        }) {
                                // Ingredients table
                                if drinkIngredients.isEmpty {
                                    HStack {
                                        HStack {
                                            Text("Add some ingredients!")
                                                .foregroundColor(Color.text)
                                                .font(.body)
                                            Spacer()
                                        }
                                    }
                                } else {
                                    ForEach(drinkIngredients, id: \.self) { ingredient in
                                        HStack {
                                            Text(ingredient)
                                                .foregroundColor(Color.text)
                                                .font(.body)
                                            Spacer()
                                        }
                                    }
                                    .onDelete(perform: deleteDrinkIngredient)
                                }
                                
                            }
                            .listRowBackground(Color.secondary)
                        }
                        
                        if typeChoices[selectedChoice] == "Symptom" {
                            // Symptom Details
                            Section(header: Text("Symptom Details")) {
                                // Symptom type
                                Picker("Type", selection: $symptomTypeChosen) {
                                    ForEach(0 ..< userData.symptomOptions.count) {
                                        Text(userData.symptomOptions[$0])
                                            .font(.body)
                                    }
                                }
                                .foregroundColor(Color.text)
                                
                                // Description
                                TextEditor(text: $symptomDescription)
                                    // make the color of the placeholder gray
                                    .foregroundColor(symptomDescription == "Notes" ? .gray : Color.text)
                                    .font(.body)
                                    .onAppear {
                                        // remove the placeholder text when keyboard appears
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if symptomDescription == "Notes" {
                                                    symptomDescription = ""
                                                }
                                            }
                                        }
                                        
                                        // put back the placeholder text if the user dismisses the keyboard without adding any text
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if symptomDescription == "" {
                                                    symptomDescription = "Notes"
                                                }
                                            }
                                        }
                                    }
                            }
                            .listRowBackground(Color.secondary)
                            
                            Section {
                                NavigationLink(destination: SymptomOptionView()) {
                                    HStack {
                                        Text("Add a new symptom")
                                            .foregroundColor(Color.text)
                                            .font(.body)
                                    }
                                }
                            }
                            .listRowBackground(Color.secondary)
                        }
                        
                        if typeChoices[selectedChoice] == "Medicine" {
                            Section(header: Text("Medicine Details")) {
                                // Medicine Types
                                Picker("Type", selection: $medicineTypeChosen) {
                                    ForEach(0 ..< userData.medicineOptions.count) {
                                        Text(userData.medicineOptions[$0])
                                            .font(.body)
                                    }
                                }
                                .foregroundColor(Color.text)
                            }
                            
                            Section {
                                NavigationLink(destination: MedicineOptionView()) {
                                    HStack {
                                        Text("Add a new medicine")
                                            .foregroundColor(Color.text)
                                            .font(.body)
                                    }
                                }
                            }
                            .listRowBackground(Color.secondary)
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
                    .buttonStyle(CustomButton())
                    .frame(width: 300, height: 50)
                    .padding()
                                        
                }
                .ignoresSafeArea(.keyboard)
                
                if showAlert {
                    AlertControlView(moc: managedObjectContext, textString: $ingredientText, showAlert: $showAlert, ingredients: $ingredients, drinkIngredients: $drinkIngredients, title: "Add Ingredient", message: "Make sure your spelling is consistent!", isDrink: false)
                }
                
                if showDrinkAlert {
                    AlertControlView(moc: managedObjectContext, textString: $ingredientText, showAlert: $showDrinkAlert, ingredients: $ingredients, drinkIngredients: $drinkIngredients, title: "Add Ingredient", message: "Make sure your spelling is consistent!", isDrink: true)
                }
            }
            .navigationTitle("Add Diary Item")
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                            .padding()
                                            .foregroundColor(Color.accent)
                                    } )
        }

    }
    
    func saveDiaryItem() {
        let item = DiaryItem(context: managedObjectContext)
        
        item.id = UUID()
        item.title = name
        item.time = timeChosen
        item.date = dateChosen
        item.type = typeChoices[selectedChoice]
        
        if item.wrappedType == "Meal" {
            item.ingredients = ingredients
            item.mealType = mealChoices[selectedMealType]
        }
        
        if item.wrappedType == "Drink" {
            item.ingredients = drinkIngredients
        }
        
        if item.wrappedType == "Symptom" {
            item.symptomType = userData.symptomOptions[symptomTypeChosen]
            item.symptomDescription = symptomDescription
        }
        
        if item.wrappedType == "Medicine" {
            item.medicineType = userData.medicineOptions[medicineTypeChosen]
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error: \(error)")
        }
        
        stats.generateStats()
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    func deleteDrinkIngredient(at offsets: IndexSet) {
        drinkIngredients.remove(atOffsets: offsets)
    }
    
    init(chosenDate: Date) {
        dateChosen = chosenDate
    }
}

struct AddDiaryItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddDiaryItemView(chosenDate: Date())
        }
    }
}
