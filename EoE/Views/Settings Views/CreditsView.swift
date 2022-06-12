//
//  CreditsView.swift
//  EoE
//
//  Created by Dakshin Devanand on 6/12/22.
//

import SwiftUI

struct CreditsView: View {
    
    var body: some View {
        
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            List {
                
                Section(header: Text("Resources")) {
                    HStack {
                        Text("App Icon")
                            .foregroundColor(Color.text)
                            .bold()
                        Spacer()
                        Text("alkhalifi_design from the Noun Project")
                            .foregroundColor(Color.text)
                    }
                }
                .listRowBackground(Color.secondary)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(Text("Credits"))
    }
    
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
