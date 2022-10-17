//
//  AppearanceApplyingStrategy.swift
//  App
//
//  Copyright © 2019 Nasaq. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore

public class AppearanceApplyingStrategy {
    
    public func apply(appearance: Appearance?, toNavigationController navigationController: UINavigationController, animated: Bool) {
        if let appearance = appearance {
            let navigationBar = navigationController.navigationBar
            let toolbar = navigationController.toolbar
            
            if !navigationController.isNavigationBarHidden && navigationBar != nil {
                let background = ImageRenderer.renderImageOfColor(color: appearance.navigationBar.backgroundColor)
                navigationBar.setBackgroundImage(background, for: .default)
                navigationBar.tintColor = appearance.navigationBar.tintColor
                navigationBar.barTintColor = appearance.navigationBar.barTintColor
                navigationBar.isTranslucent = appearance.navigationBar.isTranslucent
                navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: appearance.navigationBar.textColor ?? UIColor.black,NSAttributedString.Key.font:appearance.navigationBar.font as Any
                ]
                
                if #available(iOS 11, *) {
                    if let font = appearance.navigationBar.LargeTitlesFont, appearance.navigationBar.prefersLargeTitles {
                         navigationBar.largeTitleTextAttributes =  [
                            NSAttributedString.Key.foregroundColor: appearance.navigationBar.textColor ?? UIColor.black,NSAttributedString.Key.font: font as Any
                        ]
                    }
                    navigationBar.prefersLargeTitles = appearance.navigationBar.prefersLargeTitles

                }
                
                if let shadowImage = appearance.navigationBar.shadowImage {
                    navigationBar.shadowImage = shadowImage
                }
            }
            
            if !navigationController.isToolbarHidden {
                toolbar?.setBackgroundImage(
                    ImageRenderer.renderImageOfColor(color: appearance.toolbar.backgroundColor),
                    forToolbarPosition: .any,
                    barMetrics: .default
                )
                toolbar?.tintColor = appearance.toolbar.tintColor
                toolbar?.barTintColor = appearance.toolbar.barTintColor
            }
        }
    }
}
extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
