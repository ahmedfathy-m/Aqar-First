//
//  UIFontPlus.swift
//  Aqar First
//
//  Created by Mina Mohareb on 24/09/2022.
//

import UIKit


extension UIFont {
    
   static func customSystemFont(ofSize fontSize: CGFloat,weight:Weight) -> UIFont
    {
        if NSObject.isCurrentRTL(){
            switch weight {
            case .regular:
                return  UIFont(name: "Poppins-Regular", size:fontSize)!
                
            case .bold:
                return  UIFont(name: "Poppins-Bold", size:fontSize)!
                
            case .medium:
                return  UIFont(name: "Poppins-Medium", size:fontSize)!
                
            case .semibold:
                return  UIFont(name: "Poppins-SemiBold", size:fontSize)!
                
            case .light:
                return  UIFont(name: "Poppins-Light", size:fontSize)!
                
            case .heavy:
                return  UIFont(name: "Poppins-ExtraBold", size:fontSize)!
                
            default:
                return  UIFont(name: "Poppins-Regular", size:fontSize)!
                
            }
        }else{
            return UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
    }
    
    
}
