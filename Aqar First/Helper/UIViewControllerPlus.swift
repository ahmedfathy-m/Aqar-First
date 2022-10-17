//
//  UIViewControllerPlus.swift
//  Aqar First
//
//  Created by Mina Mohareb on 24/09/2022.
//

import UIKit
import SideMenu

extension UIViewController{
    func openSideMenu(){
        let sideMenu = RightSideMenuVC()
        let menu = SideMenuNavigationController(rootViewController: sideMenu)
//        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.leftMenuNavigationController = menu

        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
       // SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = 266
        menu.statusBarEndAlpha = 0
        present(menu, animated: true, completion: nil)
    }
}

extension UIViewController {
    func pushVC(SB:String , VCID:String , animated:Bool){
        let storyBoard = UIStoryboard(name: SB, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: VCID)
        navigationController?.pushViewController(vc, animated: animated)

    }
    
    func popVC(animated:Bool){
        navigationController?.popViewController(animated: animated)
    }

    //MARK: - Set Image as a Navigation Controller
    func setImageAsNavigation(image:String) {
        let image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.titleView = UIImageView(image: image)
    }
    
    //MARK: - Set Titile With Image in Navigation Controller
    func navTitleWithImageAndText(titleText: String, imageName: String , color: UIColor ) -> UIView {
        // Creates a new UIView
        let titleView = UIView()
        // Creates a new text label
        let label = UILabel()
        label.text = titleText
        label.sizeToFit()
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = color

        // Creates the image view
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        // Maintains the image's aspect ratio:
        let imageAspect = image.image!.size.width / image.image!.size.height
        // Sets the image frame so that it's immediately before the text:
        let imageX = label.frame.origin.x - label.frame.size.height * 1.1 //* imageAspect
        let imageY = label.frame.origin.y
        let imageWidth = label.frame.size.height * imageAspect
        let imageHeight = label.frame.size.height

        image.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        // Adds both the label and image view to the titleView
        titleView.addSubview(label)
        titleView.addSubview(image)
        // Sets the titleView frame to fit within the UINavigation Title
        titleView.sizeToFit()
        return titleView
    }
    
    //MARK: - customNavigationTitle
    func customNavigationTitle(title:String,font:UIFont,color:String){
        navigationItem.title = title
         
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: color),
                               NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    //MARK: - present View Controller
    func presentVC (storyName : String  , vcIdt: String ,  style : UIModalPresentationStyle , animated : Bool){
        let storyboard = UIStoryboard(name: storyName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdt)
        vc.modalPresentationStyle = style
        present(vc, animated: animated, completion: nil)
    }
    
  //MARK: - pullToRefreshInTableView
//    func pullTable(tableViewName:UITableView , completion:(()->())? ) {
//            tableViewName.cr.addHeadRefresh(animator: FastAnimator()) { [weak self] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                completion?()
//                tableViewName.cr.endHeaderRefresh()
//               tableViewName.reloadData()
//            })
//        }
//    }
    
//    func footerTableRefresh(tableViewName:UITableView){
//        tableViewName.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
//        /// start refres Do anything you want...
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            /// If common end
//            tableViewName.cr.endLoadingMore()
//            /// If no more data
//            tableViewName.cr.noticeNoMoreData()
//            /// Reset no more data
//            tableViewName.cr.resetNoMore()
//        })
//      }
//    }
    
    //MARK: - pullToRefreshInCollectionView
//    func pullCollection(collectionViewName:UICollectionView , completion:(()->())? ) {
//        collectionViewName.cr.addHeadRefresh(animator: FastAnimator()) { [weak self] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                completion?()
//                collectionViewName.cr.endHeaderRefresh()
//                collectionViewName.reloadData()
//            })
//        }
//    }
    
    
//    func footerCollectionRefresh(collectionViewName:UICollectionView){
//        collectionViewName.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
//        /// start refres Do anything you want...
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            /// If common end
//            collectionViewName.cr.endLoadingMore()
//            /// If no more data
//            collectionViewName.cr.noticeNoMoreData()
//            /// Reset no more data
//            collectionViewName.cr.resetNoMore()
//        })
//      }
//    }
    
  //MARK: - Pass Func as a Parameter
    func optionalFunctionExpecter(f:(()->())?) {
        f?()
    }
  //MARK: - another way to Pass Func as a Parameter
    func foo(completion: () -> Void = { }) {
        completion()
    }
    
  //MARK: - Set up Collection Skeleton View
//    func skeletonCollectionView(collectionName:UICollectionView) {
//        collectionName.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), animation: SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight))
//    }
    
    //MARK: - Set up Table Skeleton View
//      func skeletonTableView(tableViewName:UITableView) {
//        tableViewName.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), animation: SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight))
//      }
    

    
    //MARK: - Show HUDProgress
//    func showHUD(progressLabel:String){
//          DispatchQueue.main.async{
//              let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
//            progressHUD.label.text = progressLabel
//            progressHUD.mode = .indeterminate
//            progressHUD.bezelView.blurEffectStyle = .systemMaterialLight
//            progressHUD.contentColor = .darkGray
//
//          }
//      }
    //MARK: - hide HUDProgress
//      func hideHUD(isAnimated:Bool) {
//          DispatchQueue.main.async{
//              MBProgressHUD.hide(for: self.view, animated: isAnimated)
//          }
//      }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideNavigationBar () {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    var navBarHeight:CGFloat{
          let statusBarSize = UIApplication.shared.statusBarFrame.height
          let nav = UINavigationController().navigationBar.frame.height
          return nav + statusBarSize
      }
    
    func openURL(scheme: String) {
      if let url = URL(string: scheme) {
        if #available(iOS 10, *) { // For ios 10 and greater
          UIApplication.shared.open(url, options: [:],
            completionHandler: {
              (success) in
               print("Open \(scheme): \(success)")
           })
        } else { // for below ios 10.
          let success = UIApplication.shared.openURL(url)
          print("Open \(scheme): \(success)")
        }
      }
    }
    
//MARK: - restartApp
    func restartApp() {
        let confirmAlertCtrl = UIAlertController(title: "App restart required", message: "Are you ready to close the application now to change the language?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Restart", style: .destructive) { _ in
             exit(EXIT_SUCCESS)
           }
         confirmAlertCtrl.addAction(confirmAction)
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         confirmAlertCtrl.addAction(cancelAction)
         present(confirmAlertCtrl, animated: true, completion: nil)
       }
  //MARK: - Show Alert ActionSheet With completion Handler
    func showAlertActionSheet(titile:String , mesg:String , titileActionOne:String , handlerOne:(()->())? , titileActionTwo:String , handlerTwo:(()->())?) {
        let alert = UIAlertController(title: titile, message: mesg, preferredStyle: .actionSheet)

       alert.addAction(UIAlertAction(title: titileActionOne, style: .default , handler:{ (UIAlertAction)in
        handlerOne?()
          }
       ))

       alert.addAction(UIAlertAction(title: titileActionTwo, style: .default , handler:{ (UIAlertAction)in
       handlerTwo?()
      }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        print("User click Dismiss button")
      }))


     present(alert, animated: true, completion: {
        print("completion block")
       })
      }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
    }

//MARK: - Set up Navigation Component
extension UIViewController {
    func addBack(){
        let backBarButtonItem =  UIBarButtonItem(image: UIImage(named:"back-en"), style: .plain, target: self, action:#selector(closeDidPressed(_:)))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    @IBAction func closeDidPressed(_ sender:Any){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func addNormalBack(){
        let backBarButtonItem =  UIBarButtonItem(image: UIImage(named:"normal-back"), style: .plain, target: self, action:#selector(closeDidPressed(_:)))
        self.navigationItem.leftBarButtonItem = backBarButtonItem

    }
    
    func addCustomBack() {
        let backBarButtonItem =  UIBarButtonItem(image: UIImage(named:"custom-Back"), style: .plain, target: self, action:#selector(dismissDidPressed(_:)))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @IBAction func dismissDidPressed(_ sender:Any){
        
        dismiss(animated: false, completion: nil)
        
    }
    
}


extension UIViewController {
    func nullToNil(value : Any?) -> Any? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
}

extension UITableViewCell{
    //MARK: Open URL In TableViewCell
    func openURL(scheme: String) {
      if let url = URL(string: scheme) {
        if #available(iOS 10, *) { // For ios 10 and greater
          UIApplication.shared.open(url, options: [:],
            completionHandler: {
              (success) in
               print("Open \(scheme): \(success)")
           })
        } else { // for below ios 10.
          let success = UIApplication.shared.openURL(url)
          print("Open \(scheme): \(success)")
        }
      }
    }

}
