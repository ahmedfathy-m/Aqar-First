
import Foundation
import UIKit

public class AppearanceNavigationController: UINavigationController, UINavigationControllerDelegate {

    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        delegate = self
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        delegate = self
    }
    
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        delegate = self
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else {
            return
        }
        
        applyAppearance(appearance: appearanceContext.preferredNavigationControllerAppearance(navigationController: self), animated: animated)
        
    }
    // MARK: - UINavigationControllerDelegate
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
   
        if viewController.navigationItemBackButtonTextIsHidden {
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else {
            return
        }
        
        setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(navigationController: self), animated: animated)
        setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(navigationController: self), animated: animated)
        applyAppearance(appearance: appearanceContext.preferredNavigationControllerAppearance(navigationController: self), animated: animated)
        
        // interactive gesture requires more complex logic. 
        guard let coordinator = viewController.transitionCoordinator , coordinator.isInteractive else {
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in }, completion: { context in
            if context.isCancelled, let appearanceContext = self.topViewController as? NavigationControllerAppearanceContext {
                // hiding navigation bar & toolbar within interaction completion will result into inconsistent UI state
                self.setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(navigationController: self), animated: animated)
                self.setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(navigationController: self), animated: animated)
            }
        })
        coordinator.notifyWhenInteractionChanges { (context) in
            
//        }
//        coordinator.notifyWhenInteractionEnds { context in
            let key = UITransitionContextViewControllerKey.from
            if context.isCancelled, let from = context.viewController(forKey: key) as? NavigationControllerAppearanceContext {
                // changing navigation bar & toolbar appearance within animate completion will result into UI glitch
                self.applyAppearance(appearance: from.preferredNavigationControllerAppearance(navigationController: self), animated: true)
            }
        }
    }

    // mark: - Appearance Applying
    
    private var appliedAppearance: Appearance?
    
    private func applyAppearance(appearance: Appearance?, animated: Bool) {
        if appearance != nil  {//&& appliedAppearance != appearance
            appliedAppearance = appearance
            
            appearanceApplyingStrategy.apply(appearance: appearance, toNavigationController: self, animated: animated)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var appearanceApplyingStrategy = AppearanceApplyingStrategy() {
        didSet {
            applyAppearance(appearance: appliedAppearance, animated: false)
        }
    }
    
    // mark: - Apperanace Update
    
    func updateAppearanceForViewController(viewController: UIViewController) {
        if let
            context = viewController as? NavigationControllerAppearanceContext
            ,
            viewController == topViewController && transitionCoordinator == nil
        {
            setNavigationBarHidden(context.prefersNavigationControllerBarHidden(navigationController: self), animated: true)
            setToolbarHidden(context.prefersNavigationControllerToolbarHidden(navigationController: self), animated: true)
            applyAppearance(appearance: context.preferredNavigationControllerAppearance(navigationController: self), animated: true)
        }
    }

    public func updateAppearance() {
        if let top = topViewController {
            updateAppearanceForViewController(viewController: top)
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle{
        return appliedAppearance?.statusBarStyle ?? super.preferredStatusBarStyle
    }

    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return appliedAppearance != nil ? .fade : super.preferredStatusBarUpdateAnimation
    }
}
extension UIViewController {
    @objc var navigationItemBackButtonTextIsHidden: Bool { return true }
}
