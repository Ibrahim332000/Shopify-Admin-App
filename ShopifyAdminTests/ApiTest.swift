//
//  TestNetwork.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 25/02/2024.
//

import XCTest
@testable import ShopifyAdmin

class ApiTests: XCTestCase {
    
    func testGetRequest_Success() {
        let expectation = self.expectation(description: "GET Request Success")
        
        Api.get(endPoint: .createProduct) { (response: Product?, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPostRequest_Success() {
        let expectation = self.expectation(description: "POST Request Success")
        
        let params: [String: Any] = [
            "key": "value"
        ]
        
        Api.post(endPoint: .createProduct, params: params) { (response: Product?, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUpdateRequest_Success() {
        let expectation = self.expectation(description: "PUT Request Success")
        
        let params: [String: Any] = [
            "key": "value"
        ]
        
        Api.update(endPoint: .updateProduct(id: 123), params: params) { (response: Product?, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDeleteRequest_Success() {
        let expectation = self.expectation(description: "DELETE Request Success")
        
        Api.delete(endPoint: .createProduct)
        
        
        
        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
   
}



