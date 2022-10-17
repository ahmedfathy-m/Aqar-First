
import Foundation
import Alamofire
public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
    
    
}
extension DataTransferError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsing:
            return "Can't map response.".localized
        case .noResponse:
            return "No Data".localized
        case .networkFailure(let error):
            switch error {
            case .error(let statusCode,let data):
                if let dataItem = data {
//                    print(String.init(data: dataItem, encoding: .utf8))
                }
                if statusCode == 401 {
                    AuthManager.shared.loggedIn.accept(false)
                    return "The request requires user authentication.".localized
                }
                else if statusCode == -1004 {
                    return "please check your internet connection and try again".localized
                }
                
                return "Seems server is down please check your connection and try again".localized
            case .notConnected :
                return "please check your internet connection and try again".localized
                case .timeout :
                  return "The request timed out.".localized
            default:
                break
            }
            return error.localizedDescription
        case .resolvedNetworkFailure(let error):
            return error.localizedDescription
        default:
            return "No Data".localized
        }
    }
    
    
    var errorTitle: String? {
        switch self {
        default:
            return "Alert".localized
            
        }
        
    }
    
}

public protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> DataRequest? where E.Response == T
    @discardableResult
    func request<E: ResponseRequestable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<Void>) -> DataRequest? where E.Response == Void
}

public protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataTransferErrorLogger {
    func log(error: Error)
}

public final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger
    static let apiManager = AppDIContainer.init().apiDataTransferService
    
    public init(with networkService: NetworkService,
                errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
                errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                              completion: @escaping CompletionHandler<T>) -> DataRequest? where E.Response == T {
        
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                
                DispatchQueue.main.async {return completion(result)}
            case .failure(let error):
//                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }
    
    public func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> DataRequest? where E : ResponseRequestable, E.Response == Void {
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                
                DispatchQueue.main.async { return completion(.success(())) }
            case .failure(let error):
//                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                
                DispatchQueue.main.async {  return completion(.failure(error)) }
            }
        }
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
//            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Logger
public final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    public init() { }
    
    public func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
