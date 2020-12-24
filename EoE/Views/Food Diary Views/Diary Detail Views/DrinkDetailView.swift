//
//  DrinkDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/19/20.
//

import SwiftUI

struct DrinkDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    @State private var temp: [String] = [String]() // find another way to do this
    @State private var temp2: [String] = [String]() // ^
    
    @State private var showAlert: Bool = false
    @State private var ingredientText: String = ""
    
    var body: some View {
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section(header: Text("Description")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Type")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedType)
                    }
                    .foregroundColor(Color.text)
                    HStack {
                        Image(systemName: "calendar")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Date")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedDate, style: .date)
                    }
                    .foregroundColor(Color.text)
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(Color.accent)
                        Text("Time")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedTime, style: .time)
                    }
                    .foregroundColor(Color.text)
                }
                .listRowBackground(Color.secondary)
                
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
                    ForEach(fetchRequest.wrappedValue[0].wrappedIngredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteIngredient)
                }
                .listRowBackground(Color.secondary)
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.vertical)
            
            if showAlert {
                AlertControlView(moc: managedObjectContext, textString: $ingredientText, showAlert: $showAlert, ingredients: $temp, drinkIngredients: $temp2, title: "Add Ingredient", message: "Make sure your spelling is consistent!", isDrink: true, item: fetchRequest.wrappedValue[0])
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
    }
    
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
