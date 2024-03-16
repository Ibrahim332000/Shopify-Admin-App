//
//  ProductImgModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 26/02/2024.
//

import Foundation
struct ProductImgModel: Codable {
    let image: ProductImage
}

struct ProductImage: Codable {
    let id, productID, position: Int
    let width, height: Int
    let src: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case width, height, src
        
    }
}
