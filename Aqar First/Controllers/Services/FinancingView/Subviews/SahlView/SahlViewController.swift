//
//  SahlViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class SahlViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var radioYes: UIButton!
    @IBOutlet weak var radioNo: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        radioYes.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioYes.setImage(UIImage(named: "checked radio"), for: .selected)
        radioNo.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioNo.setImage(UIImage(named: "checked radio"), for: .selected)
    }
    
    // MARK: - IBActions
    @IBAction func radioAction(_ sender: UIButton) {
        radioYes.isSelected = false
        radioNo.isSelected = false
        sender.isSelected = true
    }
}
