//
//  SymptomDetailView.swift
//  EoE
//
//  Created by Dakshin Devanand on 10/19/20.
//

import SwiftUI

struct SymptomDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var fetchRequest: FetchRequest<DiaryItem>
    
    @State private var notesText: String
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section(header: Text("Description")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Type")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedType)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Date")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedDate, style: .date)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("darkPurple"))
                        Text("Time")
                        Spacer()
                        Text(fetchRequest.wrappedValue[0].wrappedTime, style: .time)
                    }
                    .foregroundColor(.white)
                }
                .listRowBackground(Color("black3"))
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notesText)
                        // make the color of the placeholder gray
                        .foregroundColor(notesText == "Notes" ? .gray : .white)
                        .font(.body)
                        .onAppear {
                            // remove the placeholder text when keyboard appears
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    if notesText == "Notes" {
                                        notesText = ""
                                    }
                                }
                            }
                            
                            // put back the placeholder text if the user dismisses the keyboard without adding any text
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    if notesText == "" {
                                        notesText = "Notes"
                                    }
                                }
                            }
                        }
                        .onChange(of: notesText, perform: { value in
                            saveNotes()
                        })
                }
                .listRowBackground(Color("black3"))
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.vertical)
        }
        .navigationTitle(fetchRequest.wrappedValue[0].wrappedTitle)
        .onTapGesture {
                self.endEditing(true)
        }
    }
    
    func saveNotes() {
        fetchRequest.wrappedValue[0].symptomDescription = notesText
        do {
            try managedObjectContext.save()
        } catch {
            print("Error while saving notes: \(error.localizedDescription)")
        }
    }
    
    init(itemID: UUID, initalNotes: String) {
        fetchRequest = FetchRequest(
            entity: DiaryItem.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "id == %@", itemID as CVarArg)
        )
        _notesText = State(initialValue: initalNotes)
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

struct SymptomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
