//
//  OrdersVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class OrdersVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var continerView:UIView!
    @IBOutlet weak var currentOrdersButton:UIButton!
    @IBOutlet weak var pendingOrdersButton:UIButton!
    @IBOutlet weak var finishOrdersButton:UIButton!


    
    //MARK: - Set Up View Controllers
    private lazy var firstViewController: CurrentOrdersVC = {
        let vc = CurrentOrdersVC()
        self.add(asChildViewController: vc)
        return vc
    }()

    private lazy var secondViewController: PendingOrdersVC = {
        let vc = PendingOrdersVC()
        self.add(asChildViewController: vc)
        return vc
    }()
    
    private lazy var thirdViewController: FinishOrdersVC = {
        let vc = FinishOrdersVC()
        self.add(asChildViewController: vc)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        hideNavigationBar()
        
        remove(asChildViewController: secondViewController)
        remove(asChildViewController: thirdViewController)

        add(asChildViewController: firstViewController)

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        self.navigationItem.hidesBackButton = true


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
    
    
    
    @IBAction func currentOrdersDidPressed(_ sender:UIButton) {
        currentOrdersButton.backgroundColor = UIColor(hex: "#4D959B")
        currentOrdersButton.setTitleColor(.white, for: .normal)
        pendingOrdersButton.backgroundColor = .white
        pendingOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        
        finishOrdersButton.backgroundColor = .white
        finishOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)

        remove(asChildViewController: secondViewController)
        remove(asChildViewController: thirdViewController)

        
        add(asChildViewController: firstViewController)

    }

    @IBAction func pendingOrdersDidPressed(_ sender:UIButton) {
        
        pendingOrdersButton.backgroundColor = UIColor(hex: "#4D959B")
        pendingOrdersButton.setTitleColor(.white, for: .normal)
        currentOrdersButton.backgroundColor = .white
        currentOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        
        finishOrdersButton.backgroundColor = .white
        finishOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)

        remove(asChildViewController: firstViewController)
        remove(asChildViewController: thirdViewController)

        
        add(asChildViewController: secondViewController)

    }
    
    @IBAction func finishOrdersDidPressed(_ sender:UIButton) {
        
        finishOrdersButton.backgroundColor = UIColor(hex: "#4D959B")
        finishOrdersButton.setTitleColor(.white, for: .normal)
        currentOrdersButton.backgroundColor = .white
        currentOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        
        pendingOrdersButton.backgroundColor = .white
        pendingOrdersButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)

        remove(asChildViewController: firstViewController)
        remove(asChildViewController: secondViewController)

        
        add(asChildViewController: thirdViewController)

    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}
