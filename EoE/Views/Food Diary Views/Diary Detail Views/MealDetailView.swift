//
//  MealDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/18/20.
//

import SwiftUI

struct MealDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    
    @State private var temp: [String] = [String]() // find another way to do this
    
    @State private var showAlert: Bool = false
    @State private var ingredientText: String = ""
    @State private var shouldAdd: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section(header: Text("Description")) {
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedMealType)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedDate, style: .date)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Text("Time")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedTime, style: .time)
                    }
                    .foregroundColor(.white)
                }
                .listRowBackground(Color("black3"))
                
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
                    ForEach(fetchRequest.wrappedValue[0].wrappedIngredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteIngredient)
                }
                .listRowBackground(Color("black3"))
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.vertical)
            
            if showAlert {
                AlertControlView(moc: managedObjectContext, textString: $ingredientText, showAlert: $showAlert, ingredients: $temp, title: "Add Ingredient", message: "Make sure your spelling is consistent!", item: fetchRequest.wrappedValue[0])
            }
        }
        .navigationTitle(fetchRequest.wrappedValue[0].wrappedTitle)
    }
    
    
     func deleteIngredient(at offsets: IndexSet) {
        managedObjectContext.performAndWait {
            fetchRequest.wrappedValue[0].ingredients!.remove(atOffsets: offsets) // this could fail if trying to delete
            do {
                try managedObjectContext.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    init(itemID: UUID) {
        fetchRequest = FetchRequest(
            entity: DiaryItem.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "id == %@", itemID as CVarArg)
        )
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
