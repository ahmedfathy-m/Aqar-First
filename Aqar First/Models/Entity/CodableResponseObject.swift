
import Foundation
import Codability

struct CodableResponseObject<T: Decodable>: Decodable {
    
    fileprivate(set) var code:Int?
    fileprivate(set) var status:Bool?
    fileprivate(set) var items:[T]?
    fileprivate(set) var errorsList:[APIError]?
    fileprivate(set) var item:T?
    fileprivate(set) var message:String?
    fileprivate(set) var errors:[[String]]?
    fileprivate(set) var pagination:Pagination?

    //    fileprivate(set) var data:Any?
    var keyResult:String = "result"
    
    private enum CodingKeys: String, CodingKey {
        case code
        case status
        case item = "result"
        case items
        case results = "data"
        // other than "result" is not supported at the moment, will do it later
        case message_ar
        case message_en
        case message
        case errors = "error_messages1"
        case errorsList = "errors"
        case detail
        case pagination
        
    }
    
    
    init(keyResult:String = "result") {
        self.keyResult = keyResult
        
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decode(Bool.self, forKey: .status)
        if let status = try? values.decode(Bool.self, forKey: .status) {
            self.status = status
        }
        else if let status = try? values.decode(Int.self, forKey: .status) {
            self.status = status == 1
        }
        code = try? values.decode(Int.self, forKey: .code)
        do {
            item = try values.decodeIfPresent(T.self, forKey: .item)
            
            if let item = try values.decodeIfPresent(T.self, forKey: .results) {
                self.item = item
            }
        } catch DecodingError.typeMismatch(_, let error){
            
            print(error)
            print(error.underlyingError)
            print("☢️ Item typemismatch error ignored")
            
            // ignore if not found
            // other types : .dataCorrupted, .keyNotFound, .typeMismatch and .valueNotFound.
        } catch let err{
            if let err = err as? DecodingError {
                print("☢️☢️☢️ ITEM Decoding Error : \(err) ☢️☢️☢️")
            }
        }
        
        do {
            items = try values.decodeIfPresent([T].self, forKey: .item)
            if let items = try values.decodeIfPresent([T].self, forKey: .results) {
                self.items = items
            }
        } catch DecodingError.typeMismatch(let e1, let e2){
            // ignore if not found
            print("⛔️ Items typemismatch error ignored")
            print(e1)
            print(e2)

        } catch let err{
            print("⛔️⛔️⛔️ ITEMS Decoding Error : \(err) ⛔️⛔️⛔️")
        }
        
        
        errors = try? values.decode([[String]].self, forKey: .errors)
        
        message = try? values.decode(String.self, forKey: .message)
      


        if let  errors = try? values.decodeAny([String].self, forKey: .errorsList),!errors.isEmpty{
//            print(" try? values.decode([NSDictionary].self, forKey: .errors)")
//            print( errors)
            self.errors = [errors]
        }
        else if  let errors = try? values.decodeAnyIfPresent(NSDictionary.self, forKey: .errorsList) {
            let listValues = errors.allValues.first as? [String] ?? []
            self.errors = [listValues]
        }

        if let message = try? values.decode(String.self, forKey: .message) ,!(self.status ?? false) {
            
            if errors == nil {
                self.errors = [[message]]

            }
            else{
                self.errors?.append([message])
            }
        }
        
        
        do {
            self.pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        } catch DecodingError.typeMismatch(_, _){
            // ignore if not found
            print("⛔️ Items typemismatch error ignored")
        } catch let err{
            print("⛔️⛔️⛔️ ITEMS Decoding Error : \(err) ⛔️⛔️⛔️")
        }
        
    }
    
    static func parse(_ data: Data)->CodableResponseObject<T>? {
        
        do {
            let resultValue = try JSONDecoder().decode( CodableResponseObject<T>.self, from:data)
            
            return resultValue
        }
        catch let error {
            
            return nil
        }
        
    }
    
}

//extension Decodable {
//    init(_ any: Any) throws {
//        let data = try JSONSerialization.data(withJSONObject: any, options: .prettyPrinted)
//        let decoder = JSONDecoder()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
//        self = try decoder.decode(Self.self, from: data)
//    }
//}
class APIError: Codable {
  
    var nonFieldErrors:String?
    
    enum CodingKeys: String, CodingKey {
        case nonFieldErrors = "non_field_errors"
   
    }
    
}


struct CodableResponsePagination<T: Decodable>: Decodable {

    var count: Int?
    var nextPageUrl:String?
    var previous:String?
    var currentPage:Int?
    var lastPage:Int?
    var items:[T]?
    var status:Bool?
    fileprivate(set) var pagination:Pagination?

    enum CodingKeys: String, CodingKey {
        case count = "total"
        case result = "data"
        case status
        case currentPage = "current_page"
        case lastPage = "last_page"
        case nextPageUrl = "next_page_url"
    }
    init()
    {
        
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decode(Bool.self, forKey: .status)
        
        do {
            if let results = try values.decodeIfPresent([T].self, forKey: .result) {
                self.items = results
            }
            
        } catch DecodingError.typeMismatch(_, _){
            // ignore if not found
            //            print("⛔️ Items typemismatch error ignored")
        } catch let err{
            //            print("⛔️⛔️⛔️ ITEMS Decoding Error : \(err) ⛔️⛔️⛔️")
        }
        
        let count = try? values.decode(Int?.self, forKey: .count) ?? 1
        let currentPage = try? values.decode(Int?.self, forKey: .currentPage) ?? 1
        let nextPageUrl = try? values.decode(String?.self, forKey: .nextPageUrl)
        
        let pagination = Pagination()
        pagination.count = count
        pagination.currentPage = currentPage
        pagination.nextPageUrl = nextPageUrl
        
        self.pagination = pagination

        
    }
    
    
    static func parse(_ data: Data)->CodableResponsePagination<T>? {
        
        do {
            let resultValue = try JSONDecoder().decode( CodableResponsePagination<T>.self, from:data)
            
            return resultValue
        }
        catch let error {
            
            return nil
        }
        
    }
}


