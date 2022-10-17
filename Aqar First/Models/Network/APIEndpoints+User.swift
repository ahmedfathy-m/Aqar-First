
import Foundation
import UIKit


extension APIEndpoints {
    
    static func signup(name:String , email:String,password:String , passwordConfirmation:String , phone:String) -> Endpoint<User>{
        return Endpoint(path: "api/signup",isAuthenticate: false,method:.post,bodyParamaters:["name":name , "email":email , "password":password , "password_confirmation":passwordConfirmation , "phone":phone])
    }
    
    
    static func login(phone:String,password:String) -> Endpoint<User> {
        return Endpoint(path: "api/login",isAuthenticate: false,
                        method:.post,bodyParamaters:["phone":phone,"password":password])
    }

}
