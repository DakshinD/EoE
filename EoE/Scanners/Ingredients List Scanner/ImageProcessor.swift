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
    /*@EnvironmentObject var progress: Progress
    @EnvironmentObject var ingredients: Ingredients
    @EnvironmentObject var showing: Showing
    @EnvironmentObject var activeScreen: ActiveScreen*/
    
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
        
        let confidenceScores = observations.compactMap { observation in
            return observation.topCandidates(1).first?.confidence
        }
        
        // Process the recognized strings.
        var recognizedText = ""
        for str in recognizedStrings {
            recognizedText += str.uppercased() + " "
        }
        
        DispatchQueue.main.async {
            /*self.ingredients.ingredientsText = recognizedText
            let allergenDetector = AllergenDetection(selectedAllergens: self.selectedAllergens)
            self.ingredients.identifiedAllergens = allergenDetector.detectAllergens(ingredientsText: self.ingredients.ingredientsText)
            self.ingredients.ingredientsText = ""
            self.showing.isDetailViewShowing = true
            withAnimation {
                self.showing.isLoading.toggle()
            }
            self.showing.image = nil
            self.progress.confidence = averageScore
            self.progress.currentProgress = 0.0*/
        }
       
    }
    
}

