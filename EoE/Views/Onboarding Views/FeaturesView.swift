//
//  FeaturesView.swift
//  EoE
//
//  Created by Dakshin Devanand on 6/11/22.
//

import SwiftUI

struct FeaturesView: View {
    
    @EnvironmentObject var userData : UserData
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true

    
    var body: some View {
        ZStack {
            
            Color.background
                 .edgesIgnoringSafeArea(.all)
                 .zIndex(0)
            
            VStack {
                Spacer()
                
                Text("Welcome")
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                    .frame(width: 300, alignment: .center)
                    .padding()
            
                    
                VStack(alignment: .leading) {
                    NewDetail(image: "doc.text.magnifyingglass", imageColor: .blue, title: "Search Ingredients", description: "Your allergens automatically spotted from ingredients labels.")
                    NewDetail(image: "text.book.closed.fill", imageColor: .orange, title: "Log Your Diet", description: "A Food Diary for your meals and symptoms.")
                    NewDetail(image: "chart.bar.xaxis", imageColor: .pink, title: "Analyze Food-Symptom Relationships", description: "Possible triggers and allergens displayed based on your own symptoms.")
                }

                Spacer()
            }
        }
        .accentColor(Color.accent)
        .preferredColorScheme(userData.darkMode ? .dark : .light)
    }
}

struct SetupView: View {
    
    @EnvironmentObject var userData : UserData
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    @State private var showAllergenSheet: Bool = false
    @State private var showSymptomSheet: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.background
                 .edgesIgnoringSafeArea(.all)
                 .zIndex(0)
            
            VStack {
                Spacer()
                
                Text("Setup")
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                    .frame(width: 300, alignment: .center)
                    .padding()
            
                Text("Fill out your allergens and common symptoms in order to use scanning and diary features.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("You can finish selections in Settings later.")
                    .font(.footnote)
                
                    
                VStack(alignment: .leading) {
                    HStack {
                        NewDetail(image: "allergens", imageColor: .blue, title: "Add Allergens", description: "Choose and add your allergens.")
                        Spacer()
                        Button(action: {
                            showAllergenSheet.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.accent)
                                Image(systemName: "arrow.forward")
                                    .frame(width: 25)
                                    .foregroundColor(Color.text)
                            }
                        }
                        .padding()
                        .sheet(isPresented: $showAllergenSheet) {
                            AllergenSelectionView()
                                .navigationTitle("Allergen Selection")
                        }
                        //Spacer()
                    }
                    HStack {
                        NewDetail(image: "brain.head.profile", imageColor: .green, title: "Add Symptoms", description: "Add common symptoms you experience after eating.")
                        Spacer()
                        Button(action: {
                            showSymptomSheet.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.accent)
                                Image(systemName: "arrow.forward")
                                    .frame(width: 25)
                                    .foregroundColor(Color.text)
                            }
                        }
                        .padding()
                        .sheet(isPresented: $showSymptomSheet) {
                            SymptomOptionView()
                        }
                        //Spacer()
                    }
                }

                Spacer()
                
                Button(action: {
                    needsAppOnboarding = false
                }) {
                    Text("Done")
                }
                .buttonStyle(CustomButton())
                .frame(width: 300, height: 50)
                .padding()
                
                Spacer()
            }
        }
        .accentColor(Color.accent)
        .preferredColorScheme(userData.darkMode ? .dark : .light)
    }
}

struct NewDetail: View {
    var image: String
    var imageColor: Color
    var title: String
    var description: String

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Image(systemName: image)
                    .font(.system(size: 50))
                    .frame(width: 50)
                    .foregroundColor(imageColor)
                    .padding()

                VStack(alignment: .leading) {
                    Text(title)//.bold()
                        .font(.headline)
                        .foregroundColor(Color.text)
                    
                
                    Text(description)
                        .fixedSize(horizontal: false, vertical: true)
                        //.font(.)
                        .foregroundColor(Color.text)
                }
            }
            .padding()
            //.frame(width: 340, height: 100)
        }
        //.padding()
    }
}

