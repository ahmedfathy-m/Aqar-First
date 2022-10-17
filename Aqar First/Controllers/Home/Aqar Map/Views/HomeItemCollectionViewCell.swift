//
//  HomeItemCollectionViewCell.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class HomeItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var continerView:UIView!
    @IBOutlet weak var aqarTitile:UILabel!
    @IBOutlet weak var aqarDescriptionLabel:UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let blur = UIBlurEffect(style: .systemThickMaterialLight)
//        let blurView = UIVisualEffectView(effect: blur)
//        blurView.frame = continerView.bounds
//
//        blurView.alpha = 0.5
//        continerView.backgroundColor = .clear
//        continerView.addSubview(blurView)
//        continerView.sendSubviewToBack(blurView)

        continerView.alpha = 0.85
    }

}
