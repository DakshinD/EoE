//
//  ScanningProcess.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

enum ScanningState {
    case closed
    case closing
    case cameraLoading
    case cameraLoaded
    case searching
    case failure
}

class ScanningProcess: ObservableObject {
    @Published var scanningState: ScanningState = .closed
    @Published var identifiedAllergens: [Allergen] = [Allergen]()
    
    // To show the scanners
    @Published var barcodeScannerShowing: Bool = false
    @Published var cameraShowing: Bool = false
    
    // To show loading view
    @Published var progress: Float = 0.0
    @Published var loadingViewShowing: Bool = false
    
    // To show result view after scanning ingredients list
    @Published var resultViewShowing: Bool = false
    @Published var foundAllergens: [String] = [String]()
    @Published var imageTaken: UIImage? = nil
    
    // To show errors after scanning barcodes
    @Published var productNotFoundErrorShowing: Bool = false
    @Published var missingInfoErrorShowing: Bool = false
    @Published var noDataErrorShowing: Bool = false
    
}
