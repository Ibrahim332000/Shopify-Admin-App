//
//  couponDiscountCodeModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 27/02/2024.
//

import Foundation

struct DiscountCodesResponse: Codable {
    let discountCodes: [DiscountCode]
    
    private enum CodingKeys: String, CodingKey {
        case discountCodes = "discount_codes"
    }
}

struct CouponDiscountCodeModel: Codable {
    let discountCode: DiscountCode
    
    private enum CodingKeys: String, CodingKey {
        case discountCode = "discount_code"
    }
}
 
struct DiscountCode: Codable {
    var code: String?
    var createdAt: String?
    var updatedAt: String?
    var id: Int?
    var priceRuleId: Int?
    var usageCount: Int?

    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id = "id"
        case priceRuleId = "price_rule_id"
        case usageCount = "usage_count"
    }
    
}
