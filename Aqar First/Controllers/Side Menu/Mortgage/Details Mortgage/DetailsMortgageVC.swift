//
//  DetailsMortgageVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class DetailsMortgageVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var continerView:UIView!
    
    @IBOutlet weak var albiladButton:UIButton!
    @IBOutlet weak var sahelButton:UIButton!



    //MARK: - Set Up View Controllers
    private lazy var firstViewController: BankAlbiladVC = {
        let vc = BankAlbiladVC()
        self.add(asChildViewController: vc)
        return vc
    }()

    private lazy var secondViewController: BankAlbiladVC = {
        let vc = BankAlbiladVC()
        self.add(asChildViewController: vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true
        hideNavigationBar()
        remove(asChildViewController: secondViewController)
        add(asChildViewController: firstViewController)

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
    
    
    @IBAction func albiladDidPressed(_ sender:UIButton) {
        albiladButton.backgroundColor = UIColor(hex: "#4D959B")
        albiladButton.setTitleColor(.white, for: .normal)
        sahelButton.backgroundColor = .white
        sahelButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        remove(asChildViewController: secondViewController)
        add(asChildViewController: firstViewController)

    }
    
    @IBAction func sahelDidPressed(_ sender:UIButton) {
        
        sahelButton.backgroundColor = UIColor(hex: "#4D959B")
        sahelButton.setTitleColor(.white, for: .normal)
        albiladButton.backgroundColor = .white
        albiladButton.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)


        remove(asChildViewController: firstViewController)
        add(asChildViewController: secondViewController)

    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}
