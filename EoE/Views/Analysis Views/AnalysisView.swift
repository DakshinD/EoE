//
//  AnalysisView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

struct AnalysisView: View {
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geo in
                
                ZStack {
                    
                    Color.background
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Spacer()
                    }
                                        
                }
                .navigationTitle("Analytics")
            }
            
        }
        
    }

}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
