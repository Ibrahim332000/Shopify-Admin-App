//
//  Network.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 22/02/2024.
//

import Foundation
import Alamofire
private let BASE_URL = "https://3c0bcd19f22e76c8f428caaba79bdb3f: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@q2-24-team1.myshopify.com/admin/api/2024-01/"

class Api : ApiProtocol{
    
    static func get<T>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable {
        
        let path = "\(BASE_URL)\(endPoint.path)"

        Alamofire.request(path).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func post<T:Codable>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {
        
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpShouldHandleCookies = false

        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")

        }catch let error{
            debugPrint(error.localizedDescription)
        }

        Alamofire.request(request).responseJSON { response in
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: response.data!) as? [String: Any] else {
                   print("Error: Cannot convert data to JSON object")
                   return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                   print("Error: Cannot convert JSON object to Pretty JSON data")
                   return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                   print("Error: Could print JSON in String")
                   return
                }
                print(prettyPrintedJson)
                
                
                guard let responseData = response.data else{return}
                print("responseData: \(responseData)")
                let result = try JSONDecoder().decode(T.self, from: responseData)

                completionHandeler(result, nil)

            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func update<T>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {
        
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.httpShouldHandleCookies = false

        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")

        }catch let error{
            debugPrint(error.localizedDescription)
        }

        Alamofire.request(request).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func delete(endPoint: EndPoints) {
        let path = "\(BASE_URL)\(endPoint.path)"

        let headers: HTTPHeaders = ["content-type": "Application/json"]
        
        Alamofire.request(path,method: .delete,headers: headers).responseJSON { response in
            guard let responseData = response.data else{return}
            print(responseData)
        }
    }
    
}
