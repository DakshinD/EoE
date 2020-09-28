//
//  ProductSearch.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import UIKit

class ProductSearch: NSObject {
    
     class func searchProduct(withBarcode barcode: String, _ completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.ingredientsRequest(for: barcode)) else {
            completion(.failure(.invalidURL))
            return
        }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ProductSearch.ProductData.self, from: data)
                if result.totalHits == 0 {
                    print("No matches")
                    completion(.failure(.productNotFound))
                    return
                }
                completion(.success(result.foods[0].ingredients))
            } catch {
                print("Error: \(error)")
                completion(.failure(.missingInfo))
            }
        }
        .resume()
    }
    
}
