//
//  WhoAreWeVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class WhoAreWeVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var contentLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true
        
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.minimumScaleFactor = 0.7
        contentLabel.numberOfLines = 0
//        contentLabel.sizeToFit()
        


    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}
