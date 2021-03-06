import UIKit

class TipCalculatorController: UIViewController {
    // MARK: - Outlets & Properties
    @IBOutlet weak var beforeTaxesAmountField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var splitBetweenLabel: UILabel!
    @IBOutlet weak var splitBetweenSlider: UISlider!
    @IBOutlet weak var afterTaxesAmountLabel: UILabel!
    @IBOutlet weak var perPersonContainterTitleLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var totalAmountContainterTitleLabel: UILabel!
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
        let tipPercentageValue = tipPercentageSlider.value
        let newPercentValue = tipPercentageValue * 100
        let newTipLabelValue = "Tip: \(Int(newPercentValue))" + "%"
        tipPercentageLabel.text = newTipLabelValue
    }
    private func updateSplitLabel(){
        splitBetweenLabel.text = "Split: \(Int(splitBetweenSlider.value))"
    }
    #warning("Refactor code below")
    private func changeColorOfView(sliderSender sender: UISlider){
        let roundedValue = round(100 * sender.value) / 100.0
        switch roundedValue {
        case 0.0...0.3:
            totalAmountView.backgroundColor = UIColor.systemGreen
            afterTaxesAmountLabel.textColor = .white
            totalAmountContainterTitleLabel.textColor = .white
        case 0.31...0.6:
            totalAmountView.backgroundColor = UIColor.systemYellow
            afterTaxesAmountLabel.textColor = .black
            totalAmountContainterTitleLabel.textColor = .black
        case 0.61...1.0:
            totalAmountView.backgroundColor = UIColor.systemRed
            afterTaxesAmountLabel.textColor = .white
            totalAmountContainterTitleLabel.textColor = .white
        default:
            print()
        }
    }
    private func changeColorOfPerPersonView(sliderSender sender: UISlider){
        switch sender.value {
        case 0...4:
            perPersonView.backgroundColor = UIColor.systemRed
            afterTaxesAmountLabel.textColor = .white
            perPersonContainterTitleLabel.textColor = .white
        case 5...8:
            perPersonView.backgroundColor = UIColor.systemOrange
            perPersonLabel.textColor = .black
             perPersonContainterTitleLabel.textColor = .black
        case 9...12:
            perPersonView.backgroundColor = UIColor.systemYellow
            perPersonLabel.textColor = .black
             perPersonContainterTitleLabel.textColor = .black
        case 13...16:
            perPersonView.backgroundColor = UIColor.systemGreen
            perPersonLabel.textColor = .white
             perPersonContainterTitleLabel.textColor = .white
        case 17...20:
            perPersonView.backgroundColor = UIColor.systemBlue
            perPersonLabel.textColor = .white
             perPersonContainterTitleLabel.textColor = .white
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
        changeColorOfPerPersonView(sliderSender: sender)
      
    }
    @IBAction func beforeTaxesTextFieldDidChange(_ sender: UITextField){
       calculateBill()
    }
    
    
}
