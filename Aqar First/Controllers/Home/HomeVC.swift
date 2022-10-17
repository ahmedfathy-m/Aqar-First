//
//  HomeVC.swift
//  Aqar First
//
//  Created by Mina Mohareb on 24/09/2022.
//

import UIKit
import GoogleMaps

class HomeVC: UIViewController {
    
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var continerView:UIView!
    @IBOutlet weak var aqarMapButton:UIButton!
    @IBOutlet weak var aqarListButton:UIButton!


    //MARK: - Set Up View Controllers
    private lazy var firstViewController: AqarMapVC = {
        let vc = AqarMapVC()
        self.add(asChildViewController: vc)
        return vc
    }()

    private lazy var secondViewController: AqarListVC = {
        let vc = AqarListVC()
        self.add(asChildViewController: vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        updateView()
        //hideNavigationBar()
        remove(asChildViewController: secondViewController)
        add(asChildViewController: firstViewController)

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)


    }

    
  

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        continerView.addSubview(viewController.view)
        viewController.view.frame = continerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
      }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
      }
    
    @IBAction func openSideMenuTapped(_ sender:UIButton) {
        openSideMenu()
        print("openSideMenu")
        
    }
    

    @IBAction func aqarMapDidPressed(_ sender:UIButton) {
        aqarMapButton.backgroundColor = UIColor(hex: "#4D959B")
        aqarMapButton.setTitleColor(.white, for: .normal)
        aqarListButton.backgroundColor = .white
        aqarListButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        remove(asChildViewController: secondViewController)
        add(asChildViewController: firstViewController)

    }
    
    @IBAction func aqarListDidPressed(_ sender:UIButton) {
        
        aqarListButton.backgroundColor = UIColor(hex: "#4D959B")
        aqarListButton.setTitleColor(.white, for: .normal)
        aqarMapButton.backgroundColor = .white
        aqarMapButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)


        remove(asChildViewController: firstViewController)
        add(asChildViewController: secondViewController)

    }
    
//    private func updateView() {
//        if segmantedControl.currentIndex == 0 {
//          remove(asChildViewController: secondViewController)
//          add(asChildViewController: firstViewController)
//
//
//      } else {
//          remove(asChildViewController: firstViewController)
//          add(asChildViewController: secondViewController)
//
//      }
//    }
//
//    func setupView(){
//      updateView()
//    }
}
