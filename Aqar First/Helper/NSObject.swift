

import Foundation
import L10n_swift
extension NSObject {
    class func storeItem<T>(_ item: T,keyName:String) where T: Codable  {
             
             if let encodedItems = try? PropertyListEncoder().encode(item){
                 UserDefaults.standard.set(encodedItems, forKey:keyName)
             }
             
         }
    class func loadItem<T>(keyName:String)->T? where T: Codable  {
           if let data = UserDefaults.standard.value(forKey:keyName) as? Data {
               if let items = try? PropertyListDecoder().decode(T.self, from: data) {
                   return items
               }
           }
           return nil
       }
    class func storeItems<T>(_ items: [T],keyName:String) where T: Codable  {
          
          if let encodedItems = try? PropertyListEncoder().encode(items){
              UserDefaults.standard.set(encodedItems, forKey:keyName)
          }
          
      }
      
      class func loadItems<T>(keyName:String)->[T]? where T: Codable  {
          if let data = UserDefaults.standard.value(forKey:keyName) as? Data {
              if let items = try? PropertyListDecoder().decode([T].self, from: data) {
                  return items
              }
          }
          return nil
      }
}

extension NSObject {
    
   static func isCurrentRTL()->Bool{
        return L10n.shared.language == "ar"
    }
}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }
    
    var className: String {
        Self.className
    }
}

extension NSObject: ClassNameProtocol {}

public extension NSObjectProtocol {
    var describedProperty: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map { element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
        }
        .joined(separator: "\n")
    }
}
