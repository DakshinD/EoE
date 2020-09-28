//
//  ProductResult.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI

extension ProductSearch {
    
    struct ProductData: Codable {
        
        let totalHits: Int
        let foods: [myFoods]

        struct myFoods: Codable {
            let description: String
            let dataType: String
            let brandOwner: String
            let ingredients: String
        }

    }
    
}
