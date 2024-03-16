//
//  LoginViewController.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 23/02/2024.
//

import UIKit
import Reachability
class LoginViewController: UIViewController {
    let reachability = try! Reachability()

    var loginViewModel:LoginViewModel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel = LoginViewModel()
        navigationItem.hidesBackButton = true

       
    }
    override func viewWillAppear(_ animated: Bool) {
           NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
           do {
               try reachability.startNotifier()
           } catch
            {
               print("Unable to start notifier")
           }
       }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        if   password.text == "" {
            CustomAlerts.presentAlert(vc: self, title: Constants.error, message: Constants.emptyFields)
        }else{
            if loginViewModel.login(customerPasssword: password.text ?? ""){
                self.errorLabel.text = "Login Successfuly"
              
                switch reachability.connection {
                 
               case .wifi , .cellular:
                   let controller = storyboard?.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal
                     present(controller, animated: true, completion: nil)
        
                  
               case .unavailable , .none:
                   let alert = UIAlertController(title:"No Internet !", message: "Make Sure Of Internet Connection", preferredStyle: .alert)
                   
                  alert.addAction(UIAlertAction(title: "Ok ", style: .default, handler: nil))
                   var imgTitle = UIImageView(frame: CGRect(x: 50, y: 14, width: 32, height: 32))
                   imgTitle.image = UIImage(named: "nointernet")
                   alert.view.addSubview(imgTitle)
                   self.present(alert, animated: true, completion: nil)
                   print(" unavailable No Connection")
              }
            }
            else{
                
                self.errorLabel.text
                = "Invalid Admin Password"
            }
        }

    }
    
  
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
 
    }
    
}
