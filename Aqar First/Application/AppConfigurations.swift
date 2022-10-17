

import Foundation
import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
//            fatalError("ApiKey must not be empty in plist")
            return ""
        }
        return apiKey
    }()
    lazy var apiBaseURL: String = {//
        switch DefaultNetworkService.networkEnviroment {
        case .dev: return "https://avaaz-admin.site"
           case .production: return "https://avaaz-admin.site"
           case .stage: return "https://avaaz-admin.site"
        }
    }()
    lazy var imagesBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
}
