import UIKit

class TipCalculatorController: UIViewController {
    // MARK: - Outlets & Properties
    @IBOutlet weak var beforeTaxesAmountField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var splitBetweenLabel: UILabel!
    @IBOutlet weak var splitBetweenSlider: UISlider!
    @IBOutlet weak var afterTaxesAmountLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var perPersonView: UIView!
    var tip = TipModel.init(amountBeforeTax: 0, tipPercentage: 0.10)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callMethods()
        let tapGest = UITapGestureRecognizer.init(target: self, action: #selector(viewDidTapped))
        view.addGestureRecognizer(tapGest)
    }
    private func callMethods(){
    setupVCSettings()
    }
    public func calculateBill(){
        let roundedValue = round(100 * tipPercentageSlider.value) / 100.0
        tip.tipPercentage = Double(roundedValue)
        tip.amountBeforeTaxes = (beforeTaxesAmountField.text! as NSString).doubleValue
        tip.calculateTip()
        updateUI()
            
        
    }
    public func updateUI(){
        afterTaxesAmountLabel.text = String(format: "$%0.2f", tip.totalAmount)
        let numOfPeople: Int = Int(splitBetweenSlider.value)
        perPersonLabel.text = String(format: "$%0.2f", tip.totalAmount / Double(numOfPeople))
    }
    private func setupVCSettings(){
    beforeTaxesAmountField.becomeFirstResponder()
    }
    @objc private func viewDidTapped(){
        beforeTaxesAmountField.resignFirstResponder()
        calculateBill()
    }
    // MARK: - Actions & Methods
    private func updatePercentageLabel() {
        tipPercentageLabel.text = String(format: "Tip: %2d%%", Int(tipPercentageSlider.value))
    }
    private func updateSplitLabel(){
        splitBetweenLabel.text = "Split: \(Int(splitBetweenSlider.value))"
    }
    private func changeColorOfView(sliderSender sender: UISlider){
        let roundedValue = round(100 * sender.value) / 100.0
        switch roundedValue {
        case 0.0...0.3:
            totalAmountView.backgroundColor = UIColor.systemGreen
        case 0.31...0.6:
            totalAmountView.backgroundColor = UIColor.systemYellow
            afterTaxesAmountLabel.textColor = .black
        case 0.61...1.0:
            totalAmountView.backgroundColor = UIColor.systemRed
        default:
            print()
        }
    }
    
    @IBAction func tipSliderDidChanged(_ sender: UISlider){
        updatePercentageLabel()
        calculateBill()
        changeColorOfView(sliderSender: sender)
       
    }
    @IBAction func splitBtwnSliderDidChanged(_ sender: UISlider){
        updateSplitLabel()
        calculateBill()
      
    }
    @IBAction func beforeTaxesTextFieldDidChange(_ sender: UITextField){
       calculateBill()
    }
    
    
}
