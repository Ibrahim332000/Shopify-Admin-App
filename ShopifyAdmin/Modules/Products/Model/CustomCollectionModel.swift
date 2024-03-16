//
//  CustomCollectionModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 26/02/2024.
//

import Foundation

struct CustomCollectionModel: Codable {
    let custom_collection: NewCustomCollection
 
}

struct AllCustomCollectionModel: Codable {
    let custom_collections: [NewCustomCollection]
 
}
 

struct NewCustomCollection: Codable {
    let id: Int
    let title: String
     
}
