//
//  NetworkManager.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import UIKit

class NetworkManager: NSObject {
    
    struct Key {
        static let fda: String = "OuOIzS97n4EieSl5uPyqAVw6SZmubdq5yZeitV7o"
    }
    
    struct APIURL {
        static func ingredientsRequest(for barcode: String) -> String {
            return "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=\(NetworkManager.Key.fda)&query=\(barcode)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
    
}

enum NetworkError: Error {
    case productNotFound
    case missingInfo
    case invalidURL
    case noData
}
