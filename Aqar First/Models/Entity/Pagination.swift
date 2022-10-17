
import Foundation

class Pagination:Codable {
    
    var count:Int? = 0
    var next:String?
    var previous:String?
    var currentPage:Int?
    var total:Int?
    var nextPageUrl:String?
 
    
    enum CodingKeys: String, CodingKey {
        
        case count
        case next
        case previous
        case currentPage = "current_page"
        case total
        case nextPageUrl = "next_page_url"
     }
    
}

