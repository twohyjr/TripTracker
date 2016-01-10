import Foundation
import UIKit
import CoreData

class GasEntriesViewController: UIViewController{
    
    var stationName: String = ""
    var tripName: String = ""
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationName = SharingManager.sharedInstance.stationName
        self.tripName = SharingManager.sharedInstance.tripName
        
//        self.tripNameLabel.text = tripName
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let gasEntryArray: [GasEntry] = FetchData()
        return gasEntryArray.count
    }

    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let gasEntryArray: [GasEntry] = FetchData()
        let cell = tableView.dequeueReusableCellWithIdentifier("GasEntryCell", forIndexPath: indexPath) as! GasEntryDisplayViewCell
        
        let date:NSDate = gasEntryArray[indexPath.row].date
        let timestamp = NSDateFormatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        let odomString: NSString = String(gasEntryArray[indexPath.row].odom)
        let store = gasEntryArray[indexPath.row].station
        
        cell.storeNameLabel.text = store
        cell.milesLabel.text = odomString as String
        cell.dateLabel.text = timestamp
        
//        cell.textLabel?.text = timestamp + "    " + (odomString as String)
        
        //tableData[indexPath.row]
        
        return cell
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
                        
                        let entry:GasEntry = GasEntry.init(date: date! as! NSDate)
                        entry.station = station! as! String
                        entry.tripname = tripName
                        entry.odom = odom as! Double
                        entry.gasprice = gasprice! as! Double
                        entry.totalgallons = totalgallons! as! Double
                        entry.totalprice = totalprice! as! Double
                        
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
    
    
}

