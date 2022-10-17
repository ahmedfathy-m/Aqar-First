//
//  ContactUsVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var textView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true
        
    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }

}
