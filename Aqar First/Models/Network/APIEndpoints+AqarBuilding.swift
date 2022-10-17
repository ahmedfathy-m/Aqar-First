
import Foundation

extension APIEndpoints {

    static func getArarBuildings() -> Endpoint<Aqar> {
           return Endpoint(path: "api/buildings",isAuthenticate: true,
                           method:.get )
       }
}
