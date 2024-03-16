//
//  NetworkProtocol.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 22/02/2024.
//

import Foundation

protocol ApiProtocol{
    
    static func get<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
    
    static func post<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    
    static  func update<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    
    static  func delete(endPoint: EndPoints)
    
}
