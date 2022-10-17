
import Foundation
import UIKit

extension Appearance {
    
    static func random() -> Appearance {
        var value = Appearance()
        
        let navigationBarColor = UIColor.randomColor()
        value.navigationBar.backgroundColor = navigationBarColor
        value.navigationBar.tintColor = navigationBarColor.isBright ? UIColor.black : UIColor.white
        
        let toolbarColor = UIColor.randomColor()
        value.toolbar.backgroundColor = toolbarColor
        value.toolbar.tintColor = toolbarColor.isBright ? UIColor.black : UIColor.white
        
        value.statusBarStyle = navigationBarColor.brightness > 0.5 ? .default : .lightContent
        
        return value
    }
    
    
    static let translucentLoginAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.clear
        value.navigationBar.tintColor = UIColor(named: "Color3")!
        //        value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor(named: "Color3")!
            if #available(iOS 13.0, *) {
                value.statusBarStyle = .darkContent
            } else {
                value.statusBarStyle = .default
            }
        value.navigationBar.font = UIFont.customSystemFont(ofSize: 17, weight: .semibold)
        //        value.navigationBar.isTranslucent = true
        //        value.navigationBar.shadowImage = UIImage()
        return value
    }()
    
    static let translucentTitleBoldAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.clear
        value.navigationBar.tintColor = UIColor.black
        //        value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor.black
        value.statusBarStyle = .lightContent
        value.navigationBar.font = UIFont.customSystemFont(ofSize: 22, weight: .semibold)
        value.navigationBar.isTranslucent = true
        value.navigationBar.shadowImage = UIImage()
        return value
    }()
    static let largeTitlesAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.clear
        value.navigationBar.tintColor = UIColor.black
        //        value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor.black
        value.statusBarStyle = .lightContent
        //        value.navigationBar.font = UIFont.HelveticaNeueW23forSKYBold(ofSize: 22)
        //        value.navigationBar.LargeTitlesFont = UIFont.HelveticaNeueW23forSKYBold(ofSize: 32)
        value.navigationBar.isTranslucent = true
        value.navigationBar.prefersLargeTitles = true
        value.navigationBar.shadowImage = UIImage()
        return value
    }()
    
    static let lightAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor(named: "clearnavigationBar")!
        value.navigationBar.tintColor = UIColor.black
        //       value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor(named: "textNavigationBar")!
        value.statusBarStyle = .lightContent
        //        value.navigationBar.font = UIFont.HelveticaNeueW23forSKYBold(ofSize: 22)
        value.navigationBar.shadowImage = UIImage()
        value.navigationBar.font = UIFont.customSystemFont(ofSize: 17, weight: .semibold)
//        value.navigationBar.isTranslucent = true

        
        return value
    }()
    
    static let lightDetailAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.clear//(named: "clearnavigationBar")!
        value.navigationBar.tintColor = UIColor.black
        //       value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor(named: "textNavigationBar")!
        value.statusBarStyle = .lightContent
        //        value.navigationBar.font = UIFont.HelveticaNeueW23forSKYBold(ofSize: 22)
        value.navigationBar.shadowImage = UIImage()
        value.navigationBar.font = UIFont.customSystemFont(ofSize: 17, weight: .semibold)
        value.navigationBar.isTranslucent = true

        
        return value
    }()
    
    
    static let greenAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor(red: 0.07, green: 0.71, blue: 0.85, alpha: 1.00)
        value.navigationBar.tintColor = UIColor.white
        
        //        value.navigationBar.barTintColor = UIColor(named: "Color1")!
        value.navigationBar.textColor = UIColor.white
        value.navigationBar.shadowImage = UIImage()
        value.statusBarStyle = .lightContent
        //        value.navigationBar.font = UIFont.HelveticaNeueW23forSKYBold(ofSize: 21)
        
        return value
    }()
    
    static let profileAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.clear
        value.navigationBar.barTintColor = UIColor(red:0.00, green:0.22, blue:0.32, alpha:1.0)
        value.navigationBar.tintColor = UIColor.black
        value.navigationBar.textColor = UIColor.black
        value.statusBarStyle = .lightContent
        //        value.navigationBar.font = UIFont.HelveticaNeueW23forSKYBold(ofSize: 24)
        value.navigationBar.shadowImage = UIImage()
        value.navigationBar.isTranslucent = true
        
        
        return value
    }()
    
    static let homeAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.tintColor = UIColor(named: "Color3")!
        //        value.navigationBar.barTintColor = UIColor.white
        value.navigationBar.textColor = UIColor(named: "Color3")!
        value.navigationBar.font = UIFont.customSystemFont(ofSize: 17, weight: .semibold)
        
        if #available(iOS 13.0, *) {
            value.statusBarStyle = .darkContent
        } else {
            value.statusBarStyle = .default
        }
        value.navigationBar.backgroundColor = UIColor.clear
        value.navigationBar.shadowImage = UIImage()
        //           value.navigationBar.isTranslucent = true
        
        return value
    }()
    
}
