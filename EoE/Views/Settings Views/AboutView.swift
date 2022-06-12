//
//  AboutView.swift
//  EoE
//
//  Created by Dakshin Devanand on 6/12/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            List {
                
                Section(header: Text("")) {
                    
                    HStack {
                        Text("Creator")
                            .foregroundColor(Color.text)
                            .bold()
                        Spacer()
                        Text("Dakshin Devanand")
                            .foregroundColor(Color.text)
                    }
                    
                    VStack {
                        Text("Background")
                            .foregroundColor(Color.text)
                            .bold()
                            .padding()
                        //Spacer()
                        Text("I created this app in order to deal with my condition: eosiniphilic esophagitis. Trying to track my diet and find what foods triggered my allergic reactions ended up being a serious difficulty for me. I hope this app could help atleast a couple people who are dealing with allergic conditions!")
                            .foregroundColor(Color.text)
                    }
                    
                }
                .listRowBackground(Color.secondary)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(Text("About"))
        
    }
}

