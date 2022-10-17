
import Foundation
import RxSwift
import RxCocoa
import SimpleKeychain

enum ActionsType {
    
    case changeToArabic
    case changeToEnglish
    case logout
}

enum UserTypeItem:Int {
    
    case guide = 3
    case travler = 1
    case office = 2
}
class AuthManager {
    
    /// The default singleton instance.
    static let shared = AuthManager()
    let loggedIn: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let notifyUpdate: PublishSubject<ActionsType> = PublishSubject()
    let userInfo: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    let forceRefersh: PublishSubject<Bool> = PublishSubject()
    let forceRefershMyTrip: PublishSubject<Bool> = PublishSubject()
    let unReadNotification: PublishSubject<Bool> = PublishSubject()
    let requestAdded: PublishSubject<Bool> = PublishSubject()

    let keychain = SimpleKeychain(service: "makatepAuth0")

    var disposeBag = DisposeBag()
    var token: String?
    
    // MARK: - Properties
    fileprivate static let userKey = "userKey"
    fileprivate  static let languageKey = "languageKey"
    fileprivate  static let currencyKey = "currencyKey"
    
    
    init() {
        //        if let token = user?.accessToken {
        //            setToken(token: token)
        //        }
        loggedIn.accept(user == nil ? false : true)
        userInfo.accept(user)
        forceRefersh.subscribe(onNext: { (forceRefersh) in
            //            self.refershUser()
        }).disposed(by: self.disposeBag)
    }
    class func loginUser(_ user: User){
        guard let accessToken = user.token else {
            return
        }
        shared.setToken(token: accessToken)
        
        // ---
        if let encodedUser = try? PropertyListEncoder().encode(user){
            UserDefaults.standard.set(encodedUser, forKey: userKey)
            
        }
        AuthManager.shared.user = user
        AuthManager.shared.userInfo.accept(user)
        shared.loggedIn.accept(true)

    }
    
    class func storeUser(_ user: User){
        //        guard user.token != nil else {
        //            return
        //        }
        if let encodedUser = try? PropertyListEncoder().encode(user){
            UserDefaults.standard.set(encodedUser, forKey: userKey)
        }
        AuthManager.shared.user = user
        AuthManager.shared.userInfo.accept(user)
    }
    
    class func updateUser(user: User){
        if let data = UserDefaults.standard.value(forKey: AuthManager.userKey) as? Data {
            if let loginResponse = try? PropertyListDecoder().decode(User.self, from: data) {
//                loginResponse.user?.name = user.user?.name
////                loginResponse.user?.email = user.user?.email
//                loginResponse.user?.phone = user.user?.phone
                
//                loginResponse.customer?.user?.name = user?.customer?.user?.name
//                loginResponse.user?.phone = user.data?.customer?.user?.phone
                

                self.storeUser(loginResponse)
            }
        }
    }
    class func updateCurancy(currency: String){
        UserDefaults.standard.set(currency, forKey:  AuthManager.currencyKey)
    }
   
    class func language()->LanguageItem{
           return  LanguageItem.init(UserDefaults.standard.value(forKey:AuthManager.languageKey) as? String ?? LanguageItem.english.code)
    }
    
    class func updateLanguage(language: String){
        UserDefaults.standard.set(language, forKey:  AuthManager.languageKey)
    }
    class func loadUser()->User?{
        if let data = UserDefaults.standard.value(forKey: AuthManager.userKey) as? Data {
            if let user = try? PropertyListDecoder().decode(User.self, from: data) {
                //                                print("useruseruseruser")
                //                                print(user)
                return user
            }
        }
        return nil
    }
    
    
    var user: User? {
        get {
            let user = AuthManager.loadUser()
//            print(" AuthManager.loadUser")
            //                                    print(user)
//            user?.token = ""
////            print(user?.first_name)
//            print(user?.email)
            //            print(user?.name)
            return user
        }
        set {
        }
    }
    
    func logout(){
        user = nil
        token = nil
        removeKeysData()
        // change at the end ( MUST )
        DispatchQueue.main.async {
            self.loggedIn.accept(false)
            AuthManager.shared.notifyUpdate.onNext(.logout)
        }
    }
    
    fileprivate func setToken(token: String) {
        // save to keychain later
        self.token = token
        //        let refreshToken = oauth.refreshToken ?? ""
        //        let expiresIn = "\(oauth.expiresIn ?? 0)"
        //        AuthManager.shared.keychain.setValue(oauth, forKey: "oauth")
        //AuthManager.shared.keychain.setString(token, forKey: "accessToken")
     try?   AuthManager.shared.keychain.set(token, forKey: "auth0-access-token")

        //        AuthManager.shared.keychain.setString(refreshToken, forKey: "refreshToken")
        //        AuthManager.shared.keychain.setString(expiresIn, forKey: "expiresIn")
        
    }
    
    
    fileprivate func removeKeysData() {
        UserDefaults.standard.removeObject(forKey: AuthManager.userKey)
    }
    
}
