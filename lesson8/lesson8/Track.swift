import Foundation
class Track{

    
    var title:String?
    var price:String?
    var previewUrl: String?
    
    init(dict: NSDictionary!){
        self.title = dict["trackName"] as? String
        self.price = dict["trackPrice"] as? String
        self.previewUrl = dict["previewUrl"] as? String
    }
}