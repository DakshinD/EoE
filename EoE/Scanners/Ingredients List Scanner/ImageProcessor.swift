//
//  ImageProcessor.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import Vision
import VisionKit

struct ImageProcessor {
    
    var selectedAllergens: [Allergen]
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var image: UIImage?
    @Binding var foundAllergens: [String]
    @Binding var resultViewShowing: Bool
    
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
                //self.progress.currentProgress = completed
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
        
        // Process the recognized strings.
        var recognizedText = ""
        for str in recognizedStrings {
            recognizedText += str.uppercased() + " "
        }
        
        DispatchQueue.main.async {
            image = nil
        // 1. Get identified allergens from AllergenDetector
            let allergenDetector = AllergenDetection(managedObjectContext)
            foundAllergens = [String]()
            foundAllergens = allergenDetector.detectAllergensInIngredientsList(ingredients: recognizedText)
        // 2. Close loading view + reset progress
            
        // 3. Manually push the detail view for the most recent scan to the users screen
            resultViewShowing.toggle()
             
        }
       
    }
    
}

