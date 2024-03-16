//
//  ProductsViewModel.swift
//
//  Created by Ibrahim on 24/02/2024.
//

import Foundation
class ProductsViewModel {
    
    var bindResultToDisplayProducts: (( ) -> Void)?
    
    var allProducts : ProductsResponse!{
        didSet{
            bindResultToDisplayProducts?()
            
        }
    }
    
    func getAllProducts (){
        Api.get(endPoint: EndPoints.createProduct ) { [weak self] (data : ProductsResponse? , error ) in
            guard let data = data else{ return}
            self?.allProducts = data
     
        }
    }
    
    func deleteProduct(productId: Int){
        Api.delete(endPoint: EndPoints.updateProduct(id: productId))
    }
}
