//
//  BiladViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class BiladViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var radioYes: UIButton!
    @IBOutlet weak var radioNo: UIButton!
    @IBOutlet weak var yearsSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radioYes.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioYes.setImage(UIImage(named: "checked radio"), for: .selected)
        radioNo.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioNo.setImage(UIImage(named: "checked radio"), for: .selected)
        yearsSlider.semanticContentAttribute = .forceRightToLeft
    }
    
    
    @IBAction func radioButtonPress(_ sender: UIButton) {
        radioYes.isSelected = false
        radioNo.isSelected = false
        sender.isSelected = true
    }
}
