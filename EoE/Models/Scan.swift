//
//  Scan.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/28/20.
//

import SwiftUI

struct Scan: Hashable, Identifiable {
    let id = UUID()
    let dateScanned: Date
    var productName: String
    var ingredients: String
    var foundAllergens: [Allergen]
}
