//
//  LoginViewModel.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 23/02/2024.
//

import Foundation

class LoginViewModel{
    
    func login(customerPasssword:String)->Bool{
        var isValid = false
        if  customerPasssword == "admin@123"{
            isValid = true
            UserDefaults.standard.set(isValid, forKey: "isValid")
            let userDefultId =  UserDefaults.standard.bool(forKey:"isValid")
            print("isValid", userDefultId )
        }
        return isValid
    }
    
  //  func isLoggedInBefore()-> Bool{
  //      return UserDefaults.standard.bool(forKey:"isValid")
   // }
    
    
}
