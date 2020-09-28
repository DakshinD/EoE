//
//  BarcodeScannerViewRepresentable.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import AVFoundation
import UIKit

struct BarcodeScannerViewRepresentable: UIViewRepresentable {
    @Binding var currentPosition: AVCaptureDevice.Position
    @Binding var scanningState: ScanningState
    let onBarcodeScanned: (String) -> ()
        
    class Coordinator: BarcodeScannerUIViewDelegate {

        @Binding var scanningState: ScanningState
        let onBarcodeScanned: (String) -> Void

        init(scanningState: Binding<ScanningState>,
             onBarcodeScanned: @escaping (String) -> Void) {
            self._scanningState = scanningState
            self.onBarcodeScanned = onBarcodeScanned
        }

        func barcodeScanningDidFail() {
            print("Failed to scan barcode.")
        }

        func barcodeScanningDidStop() {
            print("Stopped scanning barcode.")
        }

        func barcodeScanningSucceededWithCode(_ barcode: String) {
            onBarcodeScanned(barcode)
        }

        func cameraLoaded() {
            withAnimation {
                self.scanningState = ScanningState.cameraLoaded
            }
        }

        func cameraUnloaded() {
            withAnimation {
                self.scanningState = ScanningState.cameraLoading
            }
        }
    }

    func makeCoordinator() -> BarcodeScannerViewRepresentable.Coordinator {
        return Coordinator(scanningState: $scanningState,
                           onBarcodeScanned: onBarcodeScanned)
    }

    func makeUIView(context: UIViewRepresentableContext<BarcodeScannerViewRepresentable>) -> BarcodeScannerUIView {
        let view = BarcodeScannerUIView(frame: .zero)
        view.delegate = context.coordinator
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: BarcodeScannerUIView, context: UIViewRepresentableContext<BarcodeScannerViewRepresentable>) {
        uiView.updateCamera(with: currentPosition)
        uiView.backgroundColor = .clear
    }
}

protocol BarcodeScannerUIViewDelegate: class {
    func barcodeScanningDidFail()
    func barcodeScanningSucceededWithCode(_ barcode: String)
    func barcodeScanningDidStop()
    func cameraLoaded()
    func cameraUnloaded()
}


/// BarcodeScannerUIView - adapted from https://gist.github.com/abhimuralidharan/765ecaf95cbae67de81236b0786bf59f
class BarcodeScannerUIView: UIView {
    
    weak var delegate: BarcodeScannerUIViewDelegate?
    private let cameraLoadingDelay: Double = 0.5 // The delay for the AVCaptureVideoPreviewLayer to load.
    /// capture settion which allows us to start and stop scanning.
    var captureSession: AVCaptureSession?

    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitialSetup()
    }

    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }

    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }

    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }

    func startScanning() {
        captureSession?.startRunning()
    }

    func stopScanning() {
        DispatchQueue.global().async {
            self.captureSession?.stopRunning()
            self.captureSession = nil
            DispatchQueue.main.async {
                self.layer.session = nil
                self.delegate?.barcodeScanningDidStop()
            }
        }
    }

    func updateCamera(with position: AVCaptureDevice.Position) {

        func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: position)
            return discoverySession.devices.first { $0.position == position }
        }

        guard let captureSession = captureSession else {
            return
        }

        guard let currentCameraInput = captureSession.inputs.first as? AVCaptureDeviceInput else {
            return
        }

        guard currentCameraInput.device.position != position else {
            return
        }

        captureSession.beginConfiguration()
        captureSession.removeInput(currentCameraInput)

        guard let newCamera = cameraWithPosition(position: position) else {
            return
        }

        do {
            let newVideoInput = try AVCaptureDeviceInput(device: newCamera)
            captureSession.addInput(newVideoInput)
            captureSession.commitConfiguration()
        } catch  {
            // Handle this error
        }
    }

    /// Does the initial setup for captureSession
    private func doInitialSetup() {

        self.clipsToBounds = true

        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.0) {
                    self.delegate?.cameraUnloaded()
                }
            }

            let captureSession = AVCaptureSession()
            captureSession.startRunning()

            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch let error {
                print(error)
                return
            }

            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                self.scanningDidFail()
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if captureSession.canAddOutput(metadataOutput) {
                captureSession.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .upce]
            } else {
                self.scanningDidFail()
                return
            }

            self.captureSession = captureSession

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.layer.opacity = 0
                self.layer.session = self.captureSession
                self.layer.videoGravity = .resizeAspectFill

                UIView.animate(withDuration: self.cameraLoadingDelay) {
                    self.layer.opacity = 1
                    self.delegate?.cameraLoaded()
                }
            }
        }

        self.layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = .clear
    }

    func scanningDidFail() {
        delegate?.barcodeScanningDidFail()
        captureSession = nil
    }

    func found(code: String) {
        delegate?.barcodeScanningSucceededWithCode(code)
    }
}

extension BarcodeScannerUIView: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        self.stopScanning()

        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }
        
        found(code: stringValue)
    }
}

