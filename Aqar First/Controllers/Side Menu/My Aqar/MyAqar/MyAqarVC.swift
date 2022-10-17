//
//  MyAqarVC.swift
//  Aqar First
//
//  Created by no one on 14/08/2021.
//

import UIKit

class MyAqarVC: UIViewController {

    @IBOutlet weak var isThereElevatorUIView: UIView!
    @IBOutlet weak var elevatorsCompanyUIView: UIView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        hideNavigationBar()
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)
        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        isThereElevatorUIView.roundCorners(.allCorners, radius: 10)
        elevatorsCompanyUIView.roundCorners(.allCorners, radius: 10)

        self.navigationItem.hidesBackButton = true
    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
    
    @IBAction func openLocationTapped(_ sender:Any) {
        let vc = AqarLocationVC()
        navigationController?.pushViewController(vc,animated: true)
    }
}
