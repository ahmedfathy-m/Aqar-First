//
//  ProfileVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var headerView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true

    }
    
    @IBAction func editProfileDidPressed(_ sender:Any) {
        let vc = EditProfileVC()
        navigationController?.pushViewController(vc,animated: true)
    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}
