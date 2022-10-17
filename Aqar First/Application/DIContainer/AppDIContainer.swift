

import Foundation
import L10n_swift

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,headers: ["Content-Type": "application/json","device-type":"ios","language":L10n.shared.language],
                                          queryParameters: [:])//"api_key": appConfiguration.apiKey,"language": NSLocale.preferredLanguages.first ?? "en"
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imagesBaseURL)!)
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
//    // MARK: - DIContainers of scenes
//    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
//        let dependencies = MoviesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
//                                                               imageDataTransferService: imageDataTransferService)
//        return MoviesSceneDIContainer(dependencies: dependencies)
//    }
}
