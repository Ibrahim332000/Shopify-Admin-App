//
//  PriceRuleTableViewCell.swift
//  ShopifyAdmin
//
//  Created by Ibrahim on 27/02/2024.
//

import UIKit

class PriceRuleTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfRule: UILabel!
    @IBOutlet weak var ruleUsageAvailable: UILabel!
    @IBOutlet weak var quantityRule: UILabel!
    @IBOutlet weak var endTimeRule: UILabel!
    @IBOutlet weak var beginningTimeRule: UILabel!
    @IBOutlet weak var NameRule: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override var frame: CGRect{
        get {
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.origin.y += 8
            frame.size.width -= 16
            frame.size.height -= 16
            super.frame = frame
        }
    }
    
    func calculatePriceRuleData(rule:PriceRule){
        NameRule.text = rule.title
        beginningTimeRule.text = getDate(dateString: rule.startsAt!)
        endTimeRule.text = getDate(dateString: rule.endsAt!)
        quantityRule.text = getQuantityField(rule:rule)
        ruleUsageAvailable.text = "\(String(rule.usageLimit ?? 0))"
        typeOfRule.text = rule.valueType
    }
    
    func getDate(dateString: String) -> String{
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX")
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          let date = dateFormatter.date(from:dateString)!
        return date.formatted(date: .long, time: .shortened)
    }
    
    func getQuantityField(rule:PriceRule) -> String{
        let amountText = rule.value!
        return amountText
    }
    
}
