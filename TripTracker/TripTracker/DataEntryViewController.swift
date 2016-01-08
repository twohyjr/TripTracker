import Foundation

import UIKit
import CoreData

class DataEntryViewController: UIViewController{
    
    var stationName: String = ""
    var tripName: String = ""
    
    @IBOutlet weak var datePickerField: UIDatePicker!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var currentMileageTextField: UITextField!
    @IBOutlet weak var gasPriceTextField: UITextField!
    @IBOutlet weak var totalGallonsTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    
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
    
    //Creates a useable return button on the display
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func keyboardWasShown(notification: NSNotification) {
//        var info = notification.userInfo!
//        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            keyboardFrame.size.height += 20
//        })
//    }
    
}
