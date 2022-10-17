
import Foundation

enum BaseError: Error {
    
    case authLogin
    case decodeResponse
    case none
    case other(title:String,body:String)
    case inValidEmail
    case inValidPasswordCount
    case inValidEnterPassword
    case misMatchPassword
    case inValidMobile
    case emptyFirstName
    case emptyLastName
    case title
    case note
    case gender
    case birthDay
    case selectAddress
    case noData
    case valid
    case networkConnectionLost(title:String,body:String)

}
//, Error Domain=NSURLErrorDomain Code=-1200 "حدث خطأ في SSL ولا يمكن عمل اتصال آمن للخادم

extension BaseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authLogin:
            return "Please login".localized
        case .none:
            return ""
        case .decodeResponse:
            return "Can't map response.".localized
        case .inValidEmail:
            return "Please enter valid email".localized
        case .inValidPasswordCount:
            return "Please enter at least 8 characters".localized
        case .inValidMobile:
            return "Please enter valid mobile number".localized
        case .inValidEnterPassword:
            return "Please enter password".localized
        case .misMatchPassword:
            return "Passwords do not match".localized
        case .emptyFirstName:
            return "Please enter first name".localized
        case .emptyLastName:
            return "Please enter last name".localized
        case .title:
            return "Please enter title".localized
        case .note:
            return "Please enter description".localized
        case .gender:
            return "Please select gender".localized
            
        case .birthDay:
            return "Please select birth day".localized
        case .selectAddress:
            return "Please select address".localized
        case .noData:
            return "No data"
        case .other( _, let body):
            return body
        case .valid:
            return ""
        case .networkConnectionLost( _, let body):
            return body

        }
    }
    
    var errorTitle: String? {
        switch self {
        case .noData:
            return "Error".localized
        case .other(let title, _):
            return title
        case .networkConnectionLost(let title, _):
                     return title
        default:
            return "Error".localized
            
        }
        
    }
}
