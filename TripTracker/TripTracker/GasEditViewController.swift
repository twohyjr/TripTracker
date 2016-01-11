import UIKit

class GasEditViewController: UIViewController {

    //Changed Values
    var tripName: String = ""
    var station: String = ""
    var date = NSDate()
    var mileage: Double = 0.0
    var gallons: Double = 0.0
    var gasPrice: Double = 0.0
    var totalPrice: Double = 0.0
    
    //Original Values
    var otripName: String = ""
    var ostation: String = ""
    var odate = NSDate()
    var omileage: Double = 0.0
    var ogallons: Double = 0.0
    var ogasPrice: Double = 0.0
    var ototalPrice: Double = 0.0
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var dateView: UIDatePicker!
    @IBOutlet weak var mileageTextBox: UITextField!
    @IBOutlet weak var gallonsTextBox: UITextField!
    @IBOutlet weak var gasPriceTextBox: UITextField!
    @IBOutlet weak var totalPriceTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        tripNameLabel.text = otripName
        stationNameLabel.text = ostation
        dateView.setDate(odate, animated: true)
        mileageTextBox.text = String(omileage)
        gallonsTextBox.text = String(ogallons)
        gasPriceTextBox.text = String(ogasPrice)
        totalPriceTextBox.text = String(ototalPrice)
        
        mileageTextBox.enabled = false
        gallonsTextBox.enabled = false
        gasPriceTextBox.enabled = false
        totalPriceTextBox.enabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    //MARK: Edit button entries
    
    @IBAction func mileageEditButtonPressed(sender: UIButton) {
   		mileageTextBox.enabled = true
    }
    
    @IBAction func gallonsEditButtonPressed(sender: UIButton) {
        gallonsTextBox.enabled = true
    }
    
    @IBAction func gasPriceEditButtonPressed(sender: UIButton) {
        gasPriceTextBox.enabled = true
    }
    
    @IBAction func totalPriceEditButtonPressed(sender: UIButton) {
        totalPriceTextBox.enabled = true
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if(checkMileageEntry(mileageTextBox.text)
            && checkGasPriceEntry(gasPriceTextBox.text)
            && checkTotalGallonsEntry(gallonsTextBox.text)
            && checkTotalPriceEntry(totalPriceTextBox.text)){
                mileage = Double(mileageTextBox.text!)!
                date = dateView.date
                gallons = Double(gallonsTextBox.text!)!
                gasPrice = Double(gasPriceTextBox.text!)!
                totalPrice = Double(totalPriceTextBox.text!)!
                
                submitEdit()
        }else{
            resetValues()
        }
    }
    
    @IBAction func resetButtonPressed(sender: UIBarButtonItem) {
    	resetValues()
    }
    
    func resetValues(){
        tripNameLabel.text = otripName
        stationNameLabel.text = ostation
        dateView.setDate(odate, animated: true)
        mileageTextBox.text = String(omileage)
        gallonsTextBox.text = String(ogallons)
        gasPriceTextBox.text = String(ogasPrice)
        totalPriceTextBox.text = String(ototalPrice)
        
        mileageTextBox.enabled = false
        gallonsTextBox.enabled = false
        gasPriceTextBox.enabled = false
        totalPriceTextBox.enabled = false
    }
    
    func submitEdit(){
        //This is where i change the data fields then go back to entries
    }
    
    func checkMileageEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func checkGasPriceEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func checkTotalGallonsEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func checkTotalPriceEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }

}
