//
//  SearchBar.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI
import UIKit

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
        
    var body: some View {
        HStack {
            
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.tertiary)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        self.text = ""
                        
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }) {
                    Text("Cancel")
                        .foregroundColor(Color.accent)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                //.animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
