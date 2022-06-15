//
//  OnboardingView.swift
//  EoE
//
//  Created by Dakshin Devanand on 6/11/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    @EnvironmentObject var userData: UserData

    @State private var pageNum: Int = 0
    
    var body: some View {
        ZStack {
            
            Color.background
                 .edgesIgnoringSafeArea(.all)
                 .zIndex(0)
            
            VStack {
                TabView(selection: $pageNum) {
                    FeaturesView(pageNum: $pageNum)
                        .tag(0)
                    SetupView()
                        .tag(1)
                    
                }
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .tabViewStyle(PageTabViewStyle())
                
                /*Button(action: {
                    needsAppOnboarding = false
                }) {
                    Text("Onboarding Done")
                }
                .buttonStyle(CustomButton())
                .frame(width: 300, height: 50)
                .padding()*/
            }
        }
        .accentColor(Color.accent)
        .preferredColorScheme(userData.darkMode ? .dark : .light)
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
