import Foundation
import UIKit
import CoreData

class GasEntriesViewController: UIViewController{
    
    var stationName: String = ""
    var tripName: String = ""
    var gasEntryArray: [GasEntry] = [GasEntry]()
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationName = SharingManager.sharedInstance.stationName
        self.tripName = SharingManager.sharedInstance.tripName
        self.tripNameLabel.text = tripName
        navigationItem.rightBarButtonItem = editButtonItem()
        gasEntryArray = FetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return gasEntryArray.count
    }

    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("GasEntryCell", forIndexPath: indexPath) as! GasEntryDisplayViewCell
        
        let date:NSDate = gasEntryArray[indexPath.row].date
        let timestamp = NSDateFormatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        let odomString: NSString = String(gasEntryArray[indexPath.row].odom)
        let store = gasEntryArray[indexPath.row].station
        
        cell.storeNameLabel.text = store
        cell.milesLabel.text = odomString as String
        cell.dateLabel.text = timestamp
        
        //tableData[indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteEntityObject(indexPath.row, entityName: "GasEntries")
        	gasEntryArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func deleteEntityObject(index: Int, entityName: String){
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //Retrieve the data
        do{
            
            let request = NSFetchRequest(entityName: "GasEntries")
            let results = try context.executeFetchRequest(request)
            let id = gasEntryArray[index].tripID
            if(results.count > 0){
                for item in results as! [NSManagedObject]{
                    let checkId:NSManagedObjectID = item.objectID
                    if(checkId == id){
                       context.deleteObject(item)
                    }
                }
            }
            
        }catch{
            print("There was an error getting data")
        }
        
    }

//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            gasEntryArray.removeAtIndex(indexPath.row)
//            tableView.reloadData()
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let gasEditViewController = segue.destinationViewController as! GasEditViewController
            
            if let selectedGasCell = sender as? GasEntryDisplayViewCell {
                let indexPath = tableView.indexPathForCell(selectedGasCell)!
                let selectedEntry = gasEntryArray[indexPath.row]
                gasEditViewController.otripName = selectedEntry.tripname
                gasEditViewController.ostation = selectedEntry.station
                gasEditViewController.odate = selectedEntry.date
                gasEditViewController.omileage = selectedEntry.odom
                gasEditViewController.ogallons = selectedEntry.totalgallons
                gasEditViewController.ogasPrice = selectedEntry.gasprice
                gasEditViewController.ototalPrice = selectedEntry.totalprice
            }
        }
    }
    
}

