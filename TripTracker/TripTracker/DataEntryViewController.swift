import Foundation

import UIKit
import CoreData

class DataEntryViewController: UIViewController{
    
    var stationName: String = ""
    var tripName: String = ""
    
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var successLabel: UILabel!
    var activeField: UITextField?
    
    @IBOutlet weak var datePickerField: UIDatePicker!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var currentMileageTextField: UITextField!
    @IBOutlet weak var gasPriceTextField: UITextField!
    @IBOutlet weak var totalGallonsTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    
    var checkInputClear:Bool = true //Allows the form to be submitted
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        self.stationName = SharingManager.sharedInstance.stationName
        self.tripName = SharingManager.sharedInstance.tripName
        tripNameLabel.text = tripName
        stationNameLabel.text = stationName
        
        //Converts the text field into an easier user friendly keyboard
        currentMileageTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        gasPriceTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        currentMileageTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        totalGallonsTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        totalPriceTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

    @IBAction func SubmitButtonPressed(sender: UIButton) {
        //Run Through All Of The Entries To Validate Input
        if(!CheckMileageEntry(currentMileageTextField.text)){
            currentMileageTextField.backgroundColor = UIColor.redColor()
            checkInputClear = false
        }else{
            currentMileageTextField.backgroundColor = UIColor.whiteColor()
        }
        if(!CheckgasPriceTextField(gasPriceTextField.text)){
            gasPriceTextField.backgroundColor = UIColor.redColor()
            checkInputClear = false
        }else{
            gasPriceTextField.backgroundColor = UIColor.whiteColor()
        }
        if(!ChecktotalGallonsTextField(totalGallonsTextField.text)){
            totalGallonsTextField.backgroundColor = UIColor.redColor()
            checkInputClear = false
        }else{
            totalGallonsTextField.backgroundColor = UIColor.whiteColor()
        }
        if(!ChecktotalPriceTextField(totalPriceTextField.text)){
            totalPriceTextField.backgroundColor = UIColor.redColor()
            checkInputClear = false
        }else{
            totalPriceTextField.backgroundColor = UIColor.whiteColor()
        }
        
        if(checkInputClear == true){
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            //
            //Add New Entry
            let entry = NSEntityDescription.insertNewObjectForEntityForName("GasEntries", inManagedObjectContext: context)
            entry.setValue(Double(currentMileageTextField.text!), forKey: "odometer")
            entry.setValue(Double(gasPriceTextField.text!), forKey: "gasPrice")
            entry.setValue(Double(totalGallonsTextField.text!), forKey: "totalGallons")
            entry.setValue(Double(totalPriceTextField.text!), forKey: "totalPrice")
            entry.setValue(tripName, forKey: "tripName")
            entry.setValue(stationName, forKey: "gasStation")
            entry.setValue(datePickerField.date, forKey: "date")
            
            //Add Info To Entity
            do{
                try context.save()
            }catch{
                print("There was an error saving data")
                
            }

            successLabel.text = "Successful"
            currentMileageTextField.text = ""
            gasPriceTextField.text = ""
            totalGallonsTextField.text = ""
            totalPriceTextField.text = ""
            
        }else{
            successLabel.text = "Bad Input"
            checkInputClear = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

    func FetchData() -> [GasEntry]{
        var GasEntries = [GasEntry]()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //Retrieve the data
        do{
            
            let request = NSFetchRequest(entityName: "GasEntries")
            let results = try context.executeFetchRequest(request)
            
            if(results.count > 0){
                for item in results as! [NSManagedObject]{
                    let trip:String = String(item.valueForKey("tripName"))
                    
                    //Only displays the content for the current trip
                    if(trip.containsString(tripName)){
                        let station = item.valueForKey("gasStation")
                        let odom = item.valueForKey("odometer")
                        let gasprice = item.valueForKey("gasPrice")
                        let totalgallons = item.valueForKey("totalGallons")
                        let totalprice = item.valueForKey("totalPrice")
                        let date = item.valueForKey("date")
                        let tripID: NSManagedObjectID = item.objectID
                        
                        let entry:GasEntry = GasEntry.init(date: date! as! NSDate)
                        entry.station = station! as! String
                        entry.tripname = tripName
                        entry.odom = odom as! Double
                        entry.gasprice = gasprice! as! Double
                        entry.totalgallons = totalgallons! as! Double
                        entry.totalprice = totalprice! as! Double
                        entry.tripID = tripID
                        GasEntries.append(entry)
                    }
                    
                    //                    print(station!,odom!,gasprice!,totalgallons!,totalprice!,date!)
                }
            }
            
        }catch{
            print("There was an error getting data")
        }
        return GasEntries
    }
    
    func CheckStationEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func CheckMileageEntry(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func CheckgasPriceTextField(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
    func ChecktotalGallonsTextField(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    func ChecktotalPriceTextField(text: NSString?) -> Bool{
        
        if(text == ""){
            return false
        }
        
        return true
    }
    
}
