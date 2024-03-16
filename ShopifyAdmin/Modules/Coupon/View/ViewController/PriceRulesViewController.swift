//
//  PriceRulesVC.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 27/02/2024.
//

import UIKit

extension PriceRulesViewController {
    class PriceRuleConstants{
        static let cellClassName = "PriceRuleTableViewCell"
        static let cellName = "priceRuleCell"
    }
}

class PriceRulesViewController: UIViewController {
    
    var selectedRuleIndex: Int!
    var rulesList:[PriceRule] = []
    var priceRuleViewModel = PriceRuleViewModel(network: Api())
    var networkIndicator = UIActivityIndicatorView()
    var editOrAdd = ""

    @IBOutlet weak var priceRulesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
        loadIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPriceRules()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: PriceRuleConstants.cellClassName , bundle: nil)
        priceRulesTable.register(nib, forCellReuseIdentifier: PriceRuleConstants.cellName)
    }
    
    func loadIndicator(){
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.center = self.view.center
        self.view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    func getPriceRules(){
        priceRuleViewModel.getAllPriceRules {[weak self] allRules in
            self?.rulesList = allRules
            self?.networkIndicator.stopAnimating()
            self?.priceRulesTable.reloadData()
        }
    }
    
    @IBAction func addPriceRule(_ sender: Any) {
        
        editOrAdd = "add"
        
        let priceRuleVC = self.storyboard?.instantiateViewController(withIdentifier: "priceRuleVC") as! PriceRuleViewController
        
        priceRuleVC.priceRuleViewModel = priceRuleViewModel
        priceRuleVC.selectedRule = PriceRule(allocationMethod: "across" , customerSelection: "all" ,targetSelection: "all", targetType: "line_item" )
        priceRuleVC.editOrAdd = editOrAdd
        
        self.navigationController?.pushViewController(priceRuleVC, animated: true)
        
        
    }

}

extension PriceRulesViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceRuleConstants.cellName) as! PriceRuleTableViewCell
        cell.calculatePriceRuleData(rule: rulesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let alert = UIAlertController(title: Constants.warning, message: Constants.confirmDeleteRule, preferredStyle: .alert)
            let actionDelete = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
                self.priceRuleViewModel.deletePriceRule(priceRule: self.rulesList[indexPath.row])
                self.rulesList.remove(at: indexPath.row)
                self.priceRulesTable.reloadData()
            }
            let actionCancel = UIAlertAction(title: Constants.cancel, style: .cancel)
            alert.addAction(actionDelete)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
        }
        delete.image = UIImage(systemName: Constants.trashEditImage)
    
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let edit = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.prepareForEdit(index: indexPath.row)
        }
        
        edit.image = UIImage(systemName: Constants.pencilEditImage)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [edit])
        
        return swipeActions
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let discountVC = self.storyboard?.instantiateViewController(withIdentifier: "discountPage") as! DiscountsViewController
        discountVC.priceRule = rulesList[indexPath.row]
        self.navigationController?.pushViewController(discountVC, animated: true)
    }
    
    func prepareForEdit(index: Int){
        editOrAdd = "edit"
        
        let priceRuleVC = self.storyboard?.instantiateViewController(withIdentifier: "priceRuleVC") as! PriceRuleViewController
        
        priceRuleVC.priceRuleViewModel = priceRuleViewModel
        priceRuleVC.selectedRule = rulesList[index]
        priceRuleVC.editOrAdd = editOrAdd
        
        self.navigationController?.pushViewController(priceRuleVC, animated: true)
        
    }
}
