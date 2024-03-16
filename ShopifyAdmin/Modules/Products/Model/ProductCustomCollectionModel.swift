//
//  ProductCustomCollectionModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 26/02/2024.
//

import Foundation
struct ProductCustomCollectionModel: Codable {
    let collect: CustomCollection
}

// MARK: - ADDCollection
struct CustomCollection: Codable {
    let id, collection_id, product_id: Int
    let position: Int
    let sort_value: String

   
}
