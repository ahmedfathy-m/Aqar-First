
import Foundation
import Alamofire

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case timeout
    case cancelled
    case generic(Error)
    case urlGeneration
}



public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> DataRequest?
}

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> DataRequest
    
    func request(_ request: URLRequest,
                 files:[Attachment],completion: @escaping CompletionHandler) -> DataRequest
}

public protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

// MARK: - Implementation

public final class DefaultNetworkService {
    
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkErrorLogger
    let acceptableStatusCodes: [Range<Int>] = [200..<401, 402..<600]

    // MARK: - Vars & Lets
//
//       private let sessionManager: Alamofire.Session
//       private let retrier: APIManagerRetrier
    static let networkEnviroment: NetworkEnvironment = .dev
       
    
    public init(config: NetworkConfigurable,
                sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
                logger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        self.sessionManager = sessionManager
        self.config = config
        self.logger = logger
    }
    
    private func request(request: URLRequest,files:[Attachment], completion: @escaping CompletionHandler) -> DataRequest {
        
        let sessionDataTask = sessionManager.request(request,files:files) { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 401 {
                        AuthManager.shared.logout()
                        error = .error(statusCode: response.statusCode, data: data)

                    }
                    else{
                        error = .error(statusCode: response.statusCode, data: data)
                    }
                } else {
                    error = self.resolve(error: requestError)
                }
                
                self.logger.log(error: error)
                completion(.failure(error))
            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }
    
        logger.log(request: request)

        return sessionDataTask
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> DataRequest {
        
        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 401 {
                        AuthManager.shared.logout()
                        error = .error(statusCode: response.statusCode, data: data)

                    }
                    else{
                        error = .error(statusCode: response.statusCode, data: data)
                    }
                } else {
                    error = self.resolve(error: requestError)
                }
                
                self.logger.log(error: error)
                completion(.failure(error))
            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }
    
        logger.log(request: request)

        return sessionDataTask
    }
    var httpErrors = [
         NSURLErrorNetworkConnectionLost,
         NSURLErrorDataNotAllowed,
         NSURLErrorCancelled,
         NSURLErrorCannotFindHost,
         NSURLErrorTimedOut,
         NSURLErrorNotConnectedToInternet,
         NSURLErrorCannotConnectToHost,
         NSURLErrorUnknown,
         NSURLErrorBadURL,
         NSURLErrorUnsupportedURL,
         NSURLErrorDNSLookupFailed,
         NSURLErrorHTTPTooManyRedirects,
         NSURLErrorResourceUnavailable,
         NSURLErrorRedirectToNonExistentLocation,
         NSURLErrorBadServerResponse,
         NSURLErrorUserCancelledAuthentication,
         NSURLErrorUserAuthenticationRequired,
         NSURLErrorZeroByteResource,
         NSURLErrorCannotDecodeRawData,
         NSURLErrorCannotDecodeContentData,
         NSURLErrorCannotParseResponse
     ]
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        print("httpErrorshttpErrors")
        print(error)
        print(error.localizedDescription)
        print(code)
        print(httpErrors.contains(code.rawValue))
        if let underlyingError = error.asAFError?.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .timedOut:
                    print("Timed out error")
                    return .timeout
                case .notConnectedToInternet:
                    print("Not connected")
                    return .notConnected
                default:
                    return .generic(error)
                    //Do something
                    print("Unmanaged error")
                }
            }
        }
        switch code {
        case .notConnectedToInternet,.networkConnectionLost: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension DefaultNetworkService: NetworkService {
    
    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> DataRequest? {
        do {
            if let files = endpoint.files {
                let urlRequest = try endpoint.urlRequest(with: config)

                return request(request: urlRequest,files:files, completion: completion)
            }
            else{
                let urlRequest = try endpoint.urlRequest(with: config)
                return request(request: urlRequest, completion: completion)
            }
         
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
        return nil
    }
}

// MARK: - Default Network Session Manager
// Note: If authorization is needed NetworkSessionManager can be implemented by using,
// for example, Alamofire SessionManager with its RequestAdapter and RequestRetrier.
// And it can be incjected into NetworkService instead of default one.

public class DefaultNetworkSessionManager:Session, NetworkSessionManager {
    public func request(_ request: URLRequest, files: [Attachment], completion: @escaping CompletionHandler) -> DataRequest {
        let acceptableStatusCodes: [Range<Int>] = [200..<401, 402..<600]

        let task = self.upload(multipartFormData: { (multiparFormData: MultipartFormData) in
            for attachment in files {
                if let data = attachment.file {
                    multiparFormData.append(data, withName: attachment.fieldName, fileName: attachment.fileName,  mimeType: attachment.mimeType)
                } else if let url = attachment.fileURL {
                    multiparFormData.append(url, withName: attachment.fieldName, fileName: attachment.fileName,  mimeType: attachment.mimeType)
                }
            }
//            if type.actionParameters != nil {
//                for (key, value) in type.actionParameters! {
//                    if let data = (value as? String)?.data(using: .utf8) {
//                        multiparFormData.append(data, withName: key)
//                    }
//                }
//            }
        }, with: request).validate(statusCode: acceptableStatusCodes.joined())
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).response { (response) in
            completion(response.data,response.response,response.error)
        }
        
        return task
    }
    
//    public init() {}
    
    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) -> DataRequest {
        let acceptableStatusCodes: [Range<Int>] = [200..<401, 402..<600]
        
//
       let task = self.request(request).validate(statusCode: acceptableStatusCodes.joined()).response { (response) in
            completion(response.data,response.response,response.error)
        }
//        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
//        task.resume()
        
        return task
    }
}

// MARK: - Logger

public final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    public init() { }

    public func log(request: URLRequest) {
        print("-------------")
        print("request: \(request.url?.description ?? "")")
        print("headers: \(request.allHTTPHeaderFields ?? [:])")
        print("method: \(request.httpMethod?.description ?? "")")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("body: \(String(describing: resultString))")
        }
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("responseData: \(String(describing: dataDict))")
        }
        else if let text = String(data: data, encoding: .utf8) {
            printIfDebug("responseString: \(text))")

        }
        
    }

    public func log(error: Error) {
        printIfDebug("\(error)")
    }
}

// MARK: - NetworkError extension

extension NetworkError {
    public var isNotFoundError: Bool { return hasStatusCode(404) }
    
    public func hasStatusCode(_ codeError: Int) -> Bool {
        switch self {
        case let .error(code, _):
            return code == codeError
        default: return false
        }
    }
}

extension Dictionary where Key == String {
    func prettyPrint() -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
