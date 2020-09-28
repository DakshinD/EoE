//
//  ScanningProcess.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

enum ScanningState {
    case closed
    case cameraLoading
    case cameraLoaded
    case searching
    case failure
}

class ScanningProcess: ObservableObject {
    @Published var scanningState: ScanningState = .closed
}
