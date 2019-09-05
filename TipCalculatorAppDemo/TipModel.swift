import Foundation

class TipModel {
    var amountBeforeTaxes: Double = 0
    var tipAmount: Double = 0
    var tipPercentage: Double = 0
    var totalAmount: Double = 0
    
    init(amountBeforeTax amount: Double, tipPercentage percentage: Double) {
        self.amountBeforeTaxes = amount
        self.tipPercentage = percentage
    }
    
    public func calculateTip(){
        tipAmount = amountBeforeTaxes * tipPercentage
        totalAmount = tipAmount + amountBeforeTaxes
    }
}
