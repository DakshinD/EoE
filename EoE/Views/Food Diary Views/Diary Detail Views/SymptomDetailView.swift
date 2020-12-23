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
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notesText)
                        // make the color of the placeholder gray
                        .foregroundColor(notesText == "Notes" ? .gray : Color.text)
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
                .listRowBackground(Color.secondary)
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
    }
    
}

struct SymptomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
