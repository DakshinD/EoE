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
                    
                   Color.black
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(0)
                    
                    VStack {
                        
                        HStack {
                            
                            SearchBar(text: $searchText)
                            
                            HStack {
                                Button(action: {
                                    // Open ingredients list scanner
                                    scanningProcess.cameraShowing.toggle()
                                }) {
                                    Image(systemName: "doc.text.viewfinder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("darkPurple"))
                                }
                                .sheet(isPresented: $scanningProcess.cameraShowing, onDismiss: checkImage, content: { ImagePicker() })
                                
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
                                            .foregroundColor(Color("darkPurple"))
                                }
                            }
                            
                        }
                        .padding()
                        
                        List {
                            
                            Section {
                                ForEach(pastScans.filter({ searchText.isEmpty ? true : $0.wrappedProductName.lowercased().contains(searchText.lowercased()) }).sorted { $0.wrappedDate > $1.wrappedDate}, id: \.id) { scan in
                                    NavigationLink(destination: ProductView(scan: scan)) {
                                        ScanRow(scan: scan)
                                    }
                                }
                            }
                            .listRowBackground(Color("black3"))
                        }
                        .listStyle(InsetGroupedListStyle())
                        .animation(.default)
                        
                        Spacer()
                    }
                    .background(Color.black)
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
            .alert(isPresented: $scanningProcess.productNotFoundErrorShowing) {
                Alert(title: Text("Error"), message: Text("The product you scanned doesn't exist in our database"), dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $scanningProcess.missingInfoErrorShowing) {
                Alert(title: Text("Error"), message: Text("Our database doesn't contain the required info on this product"), dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $scanningProcess.noDataErrorShowing) {
                Alert(title: Text("Error"), message: Text("We are unable to access data for this specific product"), dismissButton: .default(Text("Ok")))
            }
            
        }
    }
    
    init() {
        // Changes to Navigation Bar
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

extension ScanView {
    func checkImage() {
        guard let image = scanningProcess.imageTaken else {
            return
        }
        let imageProcessor = ImageProcessor(selectedAllergens: fetchAllergens(), managedObjectContext: managedObjectContext, image: $scanningProcess.imageTaken, foundAllergens: $scanningProcess.foundAllergens, resultViewShowing: $scanningProcess.resultViewShowing, progress: $scanningProcess.progress, loadingViewShowing: $scanningProcess.loadingViewShowing)
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
