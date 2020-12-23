//
//  BarcodeScannerView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var position = AVCaptureDevice.Position.back
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var scanningProcess: ScanningProcess
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if scanningProcess.scanningState == ScanningState.cameraLoading {
                    CameraLoadingAnimation(backgroundColor: Color.accent, imageColor: Color.black)
                }
                
                if scanningProcess.scanningState != ScanningState.closed {
                    BarcodeScannerViewRepresentable(currentPosition: self.$position, scanningState: $scanningProcess.scanningState, onBarcodeScanned: { barcode in
                        guard scanningProcess.scanningState != .searching else { return }
                        scanningProcess.scanningState = .searching
                        
                        //let newBarcode = "850251004209"
                        let newBarcode = barcode.suffix(12)
                        // make network request
                        ProductSearch.searchProduct(withBarcode: String(newBarcode)){ (result) in
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                switch result {
                                case .success(let result):
                                    DispatchQueue.main.async {
                                        
                                        // 1. Get identified allergens from AllergenDetector
                                        let allergenDetector = AllergenDetection(managedObjectContext)
                                        
                                        // 2. Create new Scan object and store in CoreData
                                        let newScan = Scan(context: managedObjectContext)
                                        newScan.id = UUID()
                                        newScan.dateScanned = Date()
                                        newScan.productName = fixedDescriptionString(result.foods[0].description)
                                        newScan.ingredients = result.foods[0].ingredients
                                        let foundAllergens: [ScannedAllergen] = allergenDetector.detectAllergens(scan: newScan)
                                        for allergen in foundAllergens {
                                            newScan.addToFoundAllergens(allergen)
                                        }
                                        
                                        // add nutritional info to the scan object
                                        for nutrient in result.foods[0].foodNutrients {
                                            let newNutrient = Nutrient(context: managedObjectContext)
                                            newNutrient.id = UUID()
                                            newNutrient.nutrientName = nutrient.nutrientName
                                            newNutrient.derivationDescription = nutrient.derivationDescription
                                            newNutrient.value = nutrient.value
                                            newNutrient.unitName = nutrient.unitName
                                            newNutrient.scan = newScan
                                            newScan.addToNutrients(newNutrient)
                                        }
                                        
                                        // 3. Save context
                                        do {
                                           try managedObjectContext.save()
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                        
                                        // 4. Manually push the detail view for the most recent scan to the users screen
                                        
                                        //print(result.foods[0].description)
                                        scanningProcess.scanningState = .closing
                                    }
                                case .failure(.productNotFound):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            scanningProcess.scanningState = .failure
                                            withAnimation {
                                                scanningProcess.productNotFoundErrorShowing.toggle()
                                            }
                                        }
                                    }
                                case .failure(.missingInfo):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            scanningProcess.scanningState = .failure
                                            withAnimation {
                                                scanningProcess.missingInfoErrorShowing.toggle()
                                            }
                                        }
                                    }
                                case .failure(.noData):
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            scanningProcess.scanningState = .failure
                                            withAnimation {
                                                scanningProcess.noDataErrorShowing.toggle()
                                            }
                                        }
                                    }
                                default:
                                    break
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            scanningProcess.scanningState = .closed
                            withAnimation {
                                scanningProcess.barcodeScannerShowing.toggle()
                            }
                        }
                    })
                    .edgesIgnoringSafeArea(.all)
                }
                
                if scanningProcess.scanningState == ScanningState.searching || scanningProcess.scanningState == ScanningState.closing {
                    CameraLoadingAnimation(backgroundColor: Color.accent, imageColor: Color.black)
                }
                

                if scanningProcess.scanningState != ScanningState.closing && scanningProcess.scanningState != ScanningState.cameraLoading && scanningProcess.scanningState != ScanningState.closed {
                    BarcodeBottomBar(scanningState: $scanningProcess.scanningState)
                }

            }

        }
    }
    
    func fixedDescriptionString(_ descr: String) -> String {
        let delimiter = ","
        let names = descr.components(separatedBy: delimiter)
        var formattedName = names[0].lowercased()
        formattedName.capitalizeFirstLetter()
        return formattedName
        
    }

}


