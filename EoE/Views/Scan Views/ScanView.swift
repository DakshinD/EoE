//
//  ScanView.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import CoreData

struct ScanView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Scan.entity(),
        sortDescriptors: []
    ) var pastScans: FetchedResults<Scan>
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var scanningProcess: ScanningProcess
    
    @State private var searchText: String = ""
    @State private var scannerChoiceSheetShowing: Bool = false
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    
                   Color.background
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(0)
                    
                    VStack {
                        
                        HStack {
                            
                            SearchBar(text: $searchText)
                            
                            HStack {
                                Button(action: {
                                    // Open ingredients list scanner
                                    //scanningProcess.cameraShowing.toggle()
                                    scannerChoiceSheetShowing.toggle()
                                }) {
                                    Image(systemName: "doc.text.viewfinder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.accent)
                                }
                                .sheet(isPresented: $scanningProcess.cameraShowing, onDismiss: checkImage, content: { ImagePicker(sourceType: .camera) })
                                .sheet(isPresented: $scanningProcess.photoLibraryShowing, onDismiss: checkImage, content: { ImagePicker(sourceType: .photoLibrary) })
                                .alert(isPresented: $scanningProcess.productNotFoundErrorShowing) {
                                    Alert(title: Text("Error"), message: Text("The product you scanned doesn't exist in our database"), dismissButton: .default(Text("Ok")))
                                }
                                .confirmationDialog("Choose how you want to take a picture", isPresented: $scannerChoiceSheetShowing, titleVisibility: .visible) {
                                    Button("Camera") {
                                        print("reached")
                                        scanningProcess.cameraShowing.toggle()
                                    }
                                    Button("Photo Library") {
                                        scanningProcess.photoLibraryShowing.toggle()
                                    }
                                }
                                
                                


                                
                                Button(action: {
                                    // Open barcode scanner
                                    scanningProcess.scanningState = ScanningState.cameraLoading
                                    withAnimation {
                                        scanningProcess.barcodeScannerShowing.toggle()
                                    }
                                }) {
                                    Image(systemName: "barcode.viewfinder")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                        .foregroundColor(Color.accent)
                                }
                                .sheet(isPresented: $scanningProcess.croppingShowing, content: {
                                    ImageCropper(image: $scanningProcess.imageTaken, visible: $scanningProcess.croppingShowing, done: processImage)
                                })
                                .alert(isPresented: $scanningProcess.missingInfoErrorShowing) {
                                    Alert(title: Text("Error"), message: Text("Our database doesn't contain the required info on this product"), dismissButton: .default(Text("Ok")))
                                }
                            }
                            
                        }
                        .padding()
                        
                        List {
                            
                            Section {
                                if !pastScans.isEmpty {
                                    ForEach(pastScans.filter({ searchText.isEmpty ? true : $0.wrappedProductName.lowercased().contains(searchText.lowercased()) }).sorted { $0.wrappedDate > $1.wrappedDate}, id: \.id) { scan in
                                        NavigationLink(destination: ProductView(scan: scan)) {
                                            ScanRow(scan: scan)
                                        }
                                    }
                                    .sheet(isPresented: $scanningProcess.showProductView) {
                                        ProductView(scan: scanningProcess.mostRecentBarcodeScan)
                                            .onDisappear {
                                                scanningProcess.showProductView = false
                                            }
                                    }
                                } else {
                                    HStack {
                                        Text("Press ") + Text(Image(systemName: "barcode.viewfinder")) + Text( " to scan a product and see what allergens it has")
                                            .foregroundColor(Color.text)
                                            .font(.body)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Press ") + Text(Image(systemName: "doc.text.viewfinder")) + Text( " to scan an ingredients list for allergens")
                                            .foregroundColor(Color.text)
                                            .font(.body)
                                        Spacer()
                                    }
                                        
                                }
                            }
                            .listRowBackground(Color.secondary)
                        }
                        .listStyle(InsetGroupedListStyle())
                        //.animation(.default)
                        
                        
                        
                        Spacer()
                    }
                    .zIndex(1)
                    
                    
                    if scanningProcess.barcodeScannerShowing {
                        VStack {
                            Spacer()
                            BarcodeScannerView()
                                .frame(width: geometry.size.width-30, height: geometry.size.height-15)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.horizontal, 15)
                                .padding(.bottom, 15)
                        }
                        .transition(.slide)
                        .zIndex(2)
                    }
                    
                    if scanningProcess.loadingViewShowing {
                        ImageScanningLoadingView(progress: $scanningProcess.progress)
                            .transition(.opacity)
                            .zIndex(3)
                    }
                   
                }
                .navigationTitle("Scan")
                NavigationLink(destination: ResultView().environmentObject(scanningProcess), isActive: $scanningProcess.resultViewShowing, label: {EmptyView()})
            }
            
        }
    }
    
}

extension ScanView {
    func checkImage() {
        print("checkImage running")
        guard scanningProcess.imageTaken != nil else {
            return
        }
        // show cropping view
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            withAnimation {
                scanningProcess.croppingShowing.toggle()
            }
        }
    }
    
    func processImage(image: UIImage) {
        
        let imageProcessor = ImageProcessor(selectedAllergens: fetchAllergens(), managedObjectContext: managedObjectContext, image: $scanningProcess.imageTaken, foundAllergens: $scanningProcess.foundAllergens, foundUserCreatedAllergens: $scanningProcess.foundUserCreatedAllergens, resultViewShowing: $scanningProcess.resultViewShowing, progress: $scanningProcess.progress, loadingViewShowing: $scanningProcess.loadingViewShowing)
        imageProcessor.processImage(image: image)
        
        withAnimation {
            scanningProcess.loadingViewShowing.toggle()
        }
    }
    
    func fetchAllergens() -> [Allergen] {
        var foundAllergens: [Allergen] = [Allergen]()
        let request: NSFetchRequest<Allergen> = Allergen.fetchRequest()
        
        do {
            foundAllergens = try managedObjectContext.fetch(request)
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
        }
        
        return foundAllergens
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
            .environmentObject(UserData())
            .environmentObject(ScanningProcess())

    }
}
