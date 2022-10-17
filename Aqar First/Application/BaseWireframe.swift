

import Foundation
import UIKit
import NVActivityIndicatorView
import RxSwift
import SkeletonView

protocol WireframeInterface: class {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)
    
    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
    func showActionSheet(with title: String?, message: String?, actions: [UIAlertAction])
    
    
}
class BaseWireframe<T: BaseViewModel>: UIViewController,NavigationControllerAppearanceContext {
    
    var viewModel:T! = T()
    let disposeBag = DisposeBag()
    
    func bind(with viewModel: T) {
        self.viewModel = viewModel
        //        fatalError("You did not override configure method.. ")
        self.loadingViewObsereve(loadingObservable: self.viewModel.isLoaderHidden.asObservable(), disposeBag: self.disposeBag)
        self.errorObsereve(errorsObservable: self.viewModel.alertMessage,disposeBag: self.disposeBag,viewModel: self.viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
        return Appearance.lightAppearance
    }
    deinit {
        print("deinit \(self)")
    }
    
    
}
 
extension UIViewController: WireframeInterface {
    
    func showEmptyViewObsereve(view:UIView,showEmptyView: PublishSubject<EmptyViewType>,completeion:(()->Void)? = nil,tryHandler:(()->Void)? = nil,disposeBag:DisposeBag){
        
        showEmptyView.subscribe ( onNext:{  [weak self] (show) in
            DispatchQueue.main.async {
                if let tableView = view as? UITableView {
                    if show == .internetConnection || show == .serverError{
                        let vc = ConnectionErrorView()
                        vc.type = show
                        vc.tryAction = {
                            tryHandler?()
                        }
                        self?.addChild(vc)
                        tableView.backgroundView = vc.view
                    }
                    else{
                        tableView.backgroundView = nil
                    }
                }
                else if let collectionView = view as? UICollectionView {
                    if show == .internetConnection || show == .serverError{
                        let vc = ConnectionErrorView()
                        vc.type = show
                        vc.tryAction = {
                            tryHandler?()
                        }
                        self?.addChild(vc)
                        collectionView.backgroundView = vc.view
                    }
                    else{
                        collectionView.backgroundView = nil
                    }
                }
                
            }
        }).disposed(by:disposeBag)
    }
    
    func errorObsereve(errorsObservable: RxSwift.Observable<Error>,disposeBag:DisposeBag,viewModel:BaseViewModel){
        errorsObservable.subscribe(onNext:{  [weak self](error) in
            viewModel.isLoaderHidden.onNext(.hide)
            self?.showError(error: error )
        }).disposed(by:disposeBag)
        
    }
    
    func loadingViewObsereve(loadingObservable: RxSwift.Observable<BaseLoading>,disposeBag:DisposeBag){
        
        loadingObservable.subscribe(onNext: {  [weak self] (loading) in
            switch loading {
            case .show:
                //                print("should show loading")
                self?.showLoading()
            case .hide:
                //                print("should hide loading")
                DispatchQueue.main.async {
                    self?.view.hideLoading(view: self!.view)
                }
            case .withText(_):
                fatalError()
            case .UploadWithText(let text):
                fatalError()
            case .showSkeleton:
                //                    self?.view.showSkeleton(transition: .crossDissolve(0.2))
                DispatchQueue.main.async {
                    
                    self?.view.showAnimatedSkeleton()
                }
            case .hideSkeleton:
                DispatchQueue.main.async {
                    self?.view.hideSkeleton(reloadDataAfter: true)
                }
                
            }
        }).disposed(by:disposeBag)
        
    }
    
    func showError(error:Error){
        var message:String = error.localizedDescription
        if let baseError = error as? DataTransferError {
            switch baseError {
            case .noResponse:
                break
            default:
                message = baseError.errorDescription ?? ""
                self.showAlert(with: baseError.errorTitle, message: message)
            }
            
            
        }
        else {
            self.showAlert(with: "".localized, message: message)
            
        }
        
        DispatchQueue.main.async {
            //            self.setupMessageView(type: .error, title: "Error".localized, body: message)
        }
    }
    
    
    
    func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        showAlert(with: "Something went wrong".localized, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        let topController = self.navigationController ?? self
        topController.present(alert, animated: true, completion: nil)
    }
    func showActionSheet(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        let messageAttributed = NSMutableAttributedString(
            string: alert.message!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color3") as Any , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)])
        alert.setValue(messageAttributed, forKey: "attributedMessage")
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showLoading(){
        DispatchQueue.main.async {
            self.view.showLoadingView(parentView: self.view)
        }
    }
    
    
    
}

extension UIView{
    
    func hideLoading(view:UIView){
        DispatchQueue.main.async {
            for item in view.subviews
                where item.restorationIdentifier == "NVActivityIndicatorViewContainer1" {
                    item.removeFromSuperview()
            }
        }
        
    }
    public func showLoadingView(parentView:UIView) {
        guard let view = parentView.subviews.filter({ $0.restorationIdentifier == "NVActivityIndicatorViewContainer1" }).first else {
            let containerView = UIView(frame: parentView.frame)
            containerView.restorationIdentifier = "NVActivityIndicatorViewContainer1"
            
            containerView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            let hud = NVActivityIndicatorView(frame: CGRect.init(x: (UIScreen.main.bounds.width / 2.0) - 50 , y: UIScreen.main.bounds.midY - 50.0 , width: 40, height: 40),type:NVActivityIndicatorType.circleStrokeSpin ,color: UIColor.black)
            //            var hud = UIActivityIndicatorView(style: .gray)
            
            hud.color = UIColor.turquoise //(named: "Color1")!
            hud.tag = 10000
            hud.padding = 5
            hud.startAnimating()
            hud.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(hud)
            containerView.bringSubviewToFront(hud)
            
            // Add constraints for `activityIndicatorView`.
            ({
                let xConstraint = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: hud, attribute: .centerX, multiplier: 1, constant: 0)
                let yConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: hud, attribute: .centerY, multiplier: 1, constant: 0)
                
                containerView.addConstraints([xConstraint, yConstraint])
                }())
            parentView.addSubview(containerView)
            
            // Add constraints for `containerView`.
            ({
                let leadingConstraint = NSLayoutConstraint(item:  parentView as Any, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
                let trailingConstraint = NSLayoutConstraint(item:  parentView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
                let topConstraint = NSLayoutConstraint(item:  parentView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
                let bottomConstraint = NSLayoutConstraint(item:  parentView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
                
                parentView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
                }())
            return
        }
        if let loader = view as? NVActivityIndicatorView {
            loader.startAnimating()
        }
        
    }
}


