//
//  SmartCollectionModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 26/02/2024.
//

import Foundation

struct SmartCollectionModel: Codable {
    let smart_collection: SmartCollection
 
}

struct AllSmartCollectionModel: Codable {
    let smart_collections: [SmartCollection]
 
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let id: Int?
    let title, sort_order: String

    var image: BrandImage
}

// MARK: - Image
struct BrandImage: Codable {
    var src: String
}

// MARK: - Rule
struct Rule: Codable {
    let column, relation, condition: String
}
