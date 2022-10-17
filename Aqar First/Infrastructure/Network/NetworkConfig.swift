
import Foundation

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}
// MARK: - Enums

enum NetworkEnvironment {
    case dev
    case production
    case stage
}
extension NetworkConfigurable {    //http://rihla.centroware.com/api
    var baseURL: String {
        switch DefaultNetworkService.networkEnviroment {
        case .dev: return "https://avaaz-admin.site"
        case .production: return "https://avaaz-admin.site"
        case .stage: return "https://avaaz-admin.site"
        }
    }
    var resource: String {
        switch DefaultNetworkService.networkEnviroment {
        case .dev: return "https://avaaz-admin.site"
        case .production: return "https://avaaz-admin.site"
        case .stage: return "https://avaaz-admin.site"
        }
    }
     var headers: [String: String] {
        return  ["Accept": "application/json","Authorization":"Token \(AuthManager.shared.token ?? "")","device-type":"ios"]
    }
}
extension String {
    
    var mediaURL:URL?{
        return URL(string:ApiDataNetworkConfig.resource + self)
    }
}
public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]
    
   static var resource: String {
        switch DefaultNetworkService.networkEnviroment {
        case .dev: return "http://134.209.255.68/api"
        case .production: return "http://134.209.255.68/api"
        case .stage: return "http://134.209.255.68/api"
        }
    }
    
     public init(baseURL: URL,
                 headers: [String: String] = [:],
                 queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
