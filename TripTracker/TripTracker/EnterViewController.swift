import Foundation
import UIKit
import CoreData

class EnterViewController: UIViewController {
    
    var trips = [Trip]()
    var stations = [Station]()
    var currentSelectedTrip: String = ""
    var currentSelectedStation: String = ""
    
    
    
    @IBOutlet weak var TripNamePickerView: UIPickerView!
    @IBOutlet weak var StationNamePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trips = FetchTripData()
        stations = FetchStationData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func SubmitButtonPressed(sender: UIButton) {
        //Do Data Checks Here
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView.tag){
        case 1:
            return trips.count
        case 2:
            return stations.count
        default:
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch(pickerView.tag){
        case 1:
            currentSelectedTrip = trips[row].name
            updateTripName()
            return trips[row].name
        case 2:
            currentSelectedStation = stations[row].name
            updateStationName()
            return stations[row].name
        default:
            break
        }
        return trips[row].name
    }
    
    @IBAction func AddTripButtonPressed(sender: UIBarButtonItem) {
        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Add A New Trip",
            message: "",
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Ex: Fall 2015"
        })
        
        let action = UIAlertAction(title: "Add Trip",
            style: UIAlertActionStyle.Default,
            handler: {(paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let enteredText: String = theTextFields[0].text!
                    self.SaveTripData(enteredText)
                    self.TripNamePickerView.reloadAllComponents()
                }
        })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
    }
    
    @IBAction func AddStationButtonPressed(sender: UIBarButtonItem) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Add A New Gas Station",
            message: "",
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Ex: 7/11"
        })
        
        let action = UIAlertAction(title: "Add Station",
            style: UIAlertActionStyle.Default,
            handler: {(paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let enteredText: String = theTextFields[0].text!
                    self.SaveStationData(enteredText)
                    self.StationNamePickerView.reloadAllComponents()
                }
        })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
    }
    
    
    
    func FetchStationData() -> [Station]{
        var StationEntries = [Station]()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //Retrieve the data
        do{
            
            let request = NSFetchRequest(entityName: "Stations")
            let results = try context.executeFetchRequest(request)
            
            if(results.count > 0){
                for item in results as! [NSManagedObject]{
                    let name = item.valueForKey("stationName")
                    let id = item.valueForKey("stationId")
                    
                    let newStation: Station = Station.init(name: name! as! String, id: id as! Int)
                    
                    StationEntries.append(newStation)
                }
            }
            
        }catch{
            print("There was an error getting data")
        }
        return StationEntries
    }
    
    func FetchTripData() -> [Trip]{
        var StationEntries = [Trip]()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //Retrieve the data
        do{
            
            let request = NSFetchRequest(entityName: "Trips")
            let results = try context.executeFetchRequest(request)
            
            if(results.count > 0){
                for item in results as! [NSManagedObject]{
                    let name = item.valueForKey("tripName")
                    let id = item.valueForKey("tripId")
                    
                    let newTrip: Trip = Trip.init(name: name! as! String, id: id as! Int)
                    
                    StationEntries.append(newTrip)
                }
            }
            
        }catch{
            print("There was an error getting data")
        }
        return StationEntries
    }
    
    
    func SaveStationData(stationName: String){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //
        //Add New Entry
        let entry = NSEntityDescription.insertNewObjectForEntityForName("Stations", inManagedObjectContext: context)
        entry.setValue(String(stationName), forKey: "stationName")
        
        //Add Info To Entity
        do{
            try context.save()
            stations = FetchStationData()
        }catch{
            print("There was an error saving data")
        }
    }
    
    func SaveTripData(tripName: String){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //
        //Add New Entry
        let entry = NSEntityDescription.insertNewObjectForEntityForName("Trips", inManagedObjectContext: context)
        entry.setValue(String(tripName), forKey: "tripName")
        
        //Add Info To Entity
        do{
            try context.save()
            trips = FetchTripData()
        }catch{
            print("There was an error saving data")
        }
    }

    func updateTripName() {
        SharingManager.sharedInstance.tripName = currentSelectedTrip
    }
    
    func updateStationName() {
        SharingManager.sharedInstance.stationName = currentSelectedStation
    }
    
}

class SharingManager {
    var tripName:String = ""
    var stationName:String = ""
    static let sharedInstance = SharingManager()
}