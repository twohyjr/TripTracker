import Foundation

class Station: NSObject {
    
    var name:String = ""
    var id: Int = 0
    
    init(name:String, id: Int) {
        self.name = name
        self.id = id
    }
    
}
