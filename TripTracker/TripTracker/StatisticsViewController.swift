import Foundation
import UIKit
import CoreData


class StatisticsViewController: UIViewController{
    
    @IBOutlet weak var totalMilesTravelled: UILabel!
    @IBOutlet weak var totalGallonsUsed: UILabel!
    @IBOutlet weak var mostFrequentedStations: UILabel!
    @IBOutlet weak var averagePrice: UILabel!
    @IBOutlet weak var averageMPG: UILabel!
    @IBOutlet weak var averageMiles: UILabel!
    @IBOutlet weak var totalAmountPaid: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gasEntryArray: [GasEntry] = FetchData()
        if(gasEntryArray.count > 0){
            totalMilesTravelled.text = String(getTotalMilesTraveled(gasEntryArray))
            totalGallonsUsed.text = String(getTotalGallonsUsed(gasEntryArray))
            mostFrequentedStations.text = String(getMostFrequentedStations(gasEntryArray))
            averagePrice.text = String(getAveragePrice(gasEntryArray))
            averageMPG.text = String(getAverageMPG(gasEntryArray))
            averageMiles.text = String(getAverageMiles(gasEntryArray))
            totalAmountPaid.text = String(getTotalAmountPaid(gasEntryArray))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getTotalMilesTraveled(gasArray: [GasEntry])-> Double{
        let x : Int = gasArray.count - 1
        return gasArray[x].odom
    }
    
    func getTotalGallonsUsed(gasArray: [GasEntry])-> Double{
        var total: Double = 0
        
        for entry in gasArray{
            let tempTotal = entry.totalgallons
            total = total + tempTotal
        }
        return total
    }
    
    func getMostFrequentedStations(gasArray: [GasEntry])-> String{
        return "Casey's"
    }
    
    func getAveragePrice(gasArray: [GasEntry])-> Double{
        
        var total: Double = 0
        var count: Double = 0
        
        for entry in gasArray{
            let tempTotal = entry.gasprice
            total = total + tempTotal
            count = count + 1
        }
        total = total/count
        
        return Double(total)
    }
    
    func getAverageMPG(gasArray: [GasEntry])-> Double{
        
        var milesTravelled = [Double]()
        var gallonsArray = [Double]()
        
        var total: Double = 0
        var first: Double = 0
        var current: Double = 0
        
        var count: Double = 0
        
        for entry in gasArray{
            
            if(count != 0){
                current = first
                first = entry.odom
                total = first - current
                milesTravelled.append(total)
                gallonsArray.append(entry.totalgallons)
            }else{
                first = entry.odom
            }
            count = count + 1
        }
        
        
        let size: Int = milesTravelled.count
        var totalMilesPerGallon: Double = 0
        
        for index in 0...size-1{
            
            let miles: Double = milesTravelled[index]
            let gallons: Double = gallonsArray[index]
            
            
            totalMilesPerGallon = totalMilesPerGallon + (miles/gallons)
            
            
        }
        
        
        return totalMilesPerGallon/Double(size)
        
    }
    
    func getAverageMiles(gasArray: [GasEntry])-> Double{
        
        var total: Double = gasArray[gasArray.count - 1].odom
        let count: Double = Double(gasArray.count) - 1
        
        total = total/count
        
        return total
    }
    
    func getTotalAmountPaid(gasArray: [GasEntry])-> Double{
        var total: Double = 0
        
        for entry in gasArray{
            let tempTotal = entry.totalprice
            total = total + tempTotal
        }
        
        return total
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
                    entry.station = station! as! String
                    entry.odom = odom as! Double
                    entry.gasprice = gasprice! as! Double
                    entry.totalgallons = totalgallons! as! Double
                    entry.totalprice = totalprice! as! Double
                    
                    GasEntries.append(entry)
                    
                    //print(station!,odom!,gasprice!,totalgallons!,totalprice!,date!)
                }
            }
            
        }catch{
            print("There was an error getting data")
        }
        return GasEntries
    }
    
    
}