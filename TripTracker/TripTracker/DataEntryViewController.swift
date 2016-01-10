import Foundation

import UIKit
import CoreData

class DataEntryViewController: UIViewController{
    
    var stationName: String = ""
    var tripName: String = ""
    
    
    @IBOutlet weak var successLabel: UILabel!
    
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
            
            //Testing
//            let gasEntryArray: [GasEntry] = FetchData()
//            for items in gasEntryArray {
//                print(items.tripName)
//            }
            
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
                    let station = item.valueForKey("gasStation")
                    let odom = item.valueForKey("odometer")
                    let gasprice = item.valueForKey("gasPrice")
                    let totalgallons = item.valueForKey("totalGallons")
                    let totalprice = item.valueForKey("totalPrice")
                    let date = item.valueForKey("date")
                    
                    let entry:GasEntry = GasEntry.init(date: date! as! NSDate)
                    entry.station = stationName
                    entry.tripname = tripName
                    entry.odom = odom as! Double
                    entry.gasprice = gasprice! as! Double
                    entry.totalgallons = totalgallons! as! Double
                    entry.totalprice = totalprice! as! Double
                    
                    GasEntries.append(entry)
                    
                    print(station!,odom!,gasprice!,totalgallons!,totalprice!,date!)
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
