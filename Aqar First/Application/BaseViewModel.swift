

import Foundation
import Foundation
import Alamofire
import RxCocoa
import RxSwift

protocol BaseViewModelProtocol {
    var alertMessage: PublishSubject<Error> { get set }
    var isLoaderHidden:PublishSubject<BaseLoading> { get set }
    func handleErrorResponse<T>(reponse:CodableResponseObject<T>)
}
class BaseViewModel:NSObject,BaseViewModelProtocol {
    
    var showEmptyView: PublishSubject<EmptyViewType> = PublishSubject()

    
    let showSkeletonLoadingObservable: PublishSubject<Bool> = PublishSubject()

    var alertMessage: PublishSubject<Error> = PublishSubject()
    
    var isLoaderHidden: PublishSubject<BaseLoading> = PublishSubject()
    let apiManager = DefaultDataTransferService.apiManager// APIManager(sessionManager: Session(interceptor: OAuth2Handler(clientID: "", baseURLString: "", accessToken: "", refreshToken: "") as? RequestInterceptor), retrier: APIManagerRetrier())
    
    required override init(){
        
    }
    deinit {
        print("deinit \(self)")
    }
    func handleErrorResponse<T>(reponse: CodableResponseObject<T>) where T : Decodable {
        if reponse.code == 401 {
            AuthManager.shared.loggedIn.accept(false)
        }
        self.alertMessage.onNext(BaseError.other(title: "".localized, body: reponse.message ?? ""))
    }
    
    
}
extension BaseViewModel {
    
    func handelError(error:DataTransferError,onlyAlert:Bool = false){
        if onlyAlert {
            self.alertMessage.onNext(error)

        }
        else{
        switch error {
        case .networkFailure(let eror):
            switch eror {
            case .notConnected:
                self.showEmptyView.onNext(.internetConnection)
                break
            case .timeout:
                self.showEmptyView.onNext(.serverError)
            default:
                self.alertMessage.onNext(error)
                break
            }
            print(eror)
            break
        default:
            self.alertMessage.onNext(error)
            break
        }
        }
//        print(error.isInternetConnectionError)
    }
    
}

protocol ListBaseViewModelProtocol {
    var stopRefersh: PublishSubject<Bool> { get set }
//    var showEmptyView: PublishSubject<EmptyViewType> { get set }
    var pagination: BehaviorRelay<Pagination?> { get set }
}
enum EmptyViewType {
    case internetConnection
    case serverError
    case notLogin
    case defaultView
    case none
}
class ListBaseViewModel<T>:BaseViewModel,ListBaseViewModelProtocol {
    var stopRefersh: PublishSubject<Bool> = PublishSubject()
    var pagination: BehaviorRelay<Pagination?> = BehaviorRelay(value: nil)
    let items: BehaviorRelay<[T]> = BehaviorRelay(value: [])
    var page:Int = 0

    var request: DataRequest?
    
 
    func handleErrorResponse(error:Error) {
//        switch error as? BaseError{
//        case .networkConnectionLost(let title,let body):
////            self.showEmptyView.onNext(.internetConnection)
//        default:
//            break
//        }
        self.alertMessage.onNext(error)
    }
 
     func preparePagination(refersh:Bool)->Int?{
            if refersh {
                self.pagination.accept(nil)
            }
            let page:Int = (self.page) + 1
            if let pagination = self.pagination.value  {
                if pagination.nextPageUrl == nil {
                    stopRefersh.onNext(true)
                    return nil
                }
                else{
                    guard let url = URL.init(string: pagination.nextPageUrl ?? "") else {
                        return 1
                    }
                    return Int(url.queryParameters?["page"] ?? "1")
                }
            }
            else{
                self.isLoaderHidden.onNext(.showSkeleton)
            }
            self.page = page
            return 1
            
        }
    
    // MARK: - Private Methods
    
    func loadData(refersh:Bool = false) {
        
        
    }
    
}
