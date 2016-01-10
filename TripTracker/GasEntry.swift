import Foundation

class GasEntry: NSObject {
    
    var tripname:String = ""
    var station:String = ""
    var odom:Double = 0.0
    var gasprice:Double = 0.0
    var totalgallons:Double = 0.0
    var totalprice:Double = 0.0
    var date:NSDate
    
    init(date:NSDate) {
        self.date = date
    }
    
}
