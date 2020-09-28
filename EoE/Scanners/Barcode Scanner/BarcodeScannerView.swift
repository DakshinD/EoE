//
//  BarcodeScannerView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var scanningState: ScanningState
    @State private var position = AVCaptureDevice.Position.back
    
    var selectedAllergens: [Allergen]
    /*@EnvironmentObject var progress: Progress
    @EnvironmentObject var ingredients: Ingredients
    @EnvironmentObject var showing: Showing
    @EnvironmentObject var activeScreen: ActiveScreen
    @EnvironmentObject var errorsShown: Errors*/
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.scanningState == ScanningState.cameraLoading {
                    //CameraLoadingView()
                }
                
                if self.scanningState != ScanningState.closed {
                    BarcodeScannerViewRepresentable(currentPosition: self.$position, scanningState: self.$scanningState, onBarcodeScanned: { barcode in
                        guard self.scanningState != .searching else { return }
                        self.scanningState = .searching
                        
                        //let newBarcode = "850251004209"
                        let newBarcode = barcode.suffix(12)
                        // make network request
                        ProductSearch.searchProduct(withBarcode: String(newBarcode)){ (result) in
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                switch result {
                                case .success(let ingredients):
                                    DispatchQueue.main.async {
                                        /*self.ingredients.ingredientsText = ingredients
                                        let allergenDetector = AllergenDetection(selectedAllergens: self.selectedAllergens)
                                        self.ingredients.identifiedAllergens = allergenDetector.detectAllergens(ingredientsText: self.ingredients.ingredientsText)
                                        self.ingredients.ingredientsText = ""
                                        self.showing.isDetailViewShowing = true
                                        self.showing.image = nil*/
                                        self.scanningState = .closed
                                    }
                                case .failure(.productNotFound):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            self.scanningState = .failure
                                            //self.errorsShown.productNotFound.toggle()
                                        }
                                    }
                                case .failure(.missingInfo):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            self.scanningState = .failure
                                            //self.errorsShown.missingData.toggle()
                                        }
                                    }
                                case .failure(.noData):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            self.scanningState = .failure
                                            //self.errorsShown.dataNotFound.toggle()
                                        }
                                    }
                                default:
                                    break
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                    .edgesIgnoringSafeArea(.all)
                }
                
                if self.scanningState == ScanningState.searching {
                    //NetworkRequestLoadingView()
                }
                
                //BarcodeBottomBar(scanningState: self.$scanningState)

            }

        }
    }

}


