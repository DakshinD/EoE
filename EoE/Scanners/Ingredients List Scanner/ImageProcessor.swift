//
//  ImageProcessor.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import Vision
import VisionKit
import CoreData

struct ImageProcessor {
    
    var selectedAllergens: [Allergen]
    
    var managedObjectContext: NSManagedObjectContext
    
    @Binding var image: UIImage?
    @Binding var foundAllergens: [String]
    @Binding var foundUserCreatedAllergens: [String]
    @Binding var resultViewShowing: Bool
    @Binding var progress: Float
    @Binding var loadingViewShowing: Bool
    
    func processImage(image: UIImage) {
        // Get image
        guard let cgImage = image.cgImage else { return }
        // Create a new request handler
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        // Create a request
        let request = VNRecognizeTextRequest(completionHandler:
            recognizeTextHandler)
        // Update progress of the text recognition
        request.progressHandler = {(request, completed, error) in
            DispatchQueue.main.async {
                progress = Float(completed)
            }
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["es"]
        request.usesLanguageCorrection = true

        DispatchQueue.global(qos: .userInteractive).async {
            do {
                // Perform the text-recognition request.
                try requestHandler.perform([request])
            } catch {
                print("Unable to perform the requests: \(error).")
            }
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        print("Recognized String: \(recognizedStrings)")
        if recognizedStrings.isEmpty { // if no words recognized
            print("it was empty")
            DispatchQueue.main.async {
                withAnimation {
                    loadingViewShowing.toggle()
                }
                progress = 0.0
            }
            return
        }
        // Process the recognized strings.
        var recognizedText = ""
        for str in recognizedStrings {
            recognizedText += str.uppercased() + " "
        }
        
        if recognizedText == "" {
            DispatchQueue.main.async {
                withAnimation {
                    loadingViewShowing.toggle()
                }
                progress = 0.0
            }
            return
        }
        
        print(recognizedText.splitIntoIngredients())
                        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
            image = nil
        // 1. Get identified allergens from AllergenDetector
            let allergenDetector = AllergenDetection(managedObjectContext)
            foundAllergens = [String]()
            foundAllergens = allergenDetector.detectAllergensInIngredientsList(ingredients: recognizedText)
            foundUserCreatedAllergens = [String]()
            foundUserCreatedAllergens = allergenDetector.detectUserCreatedAllergensInIngredientsList(ingredients: recognizedText)
            
        // 2. Manually push the detail view for the most recent scan to the users screen
            resultViewShowing.toggle()
            
        // 3. Reset all values + close loading view
            withAnimation {
                loadingViewShowing.toggle()
            }
            progress = 0.0
        
        }

    }
    
}

