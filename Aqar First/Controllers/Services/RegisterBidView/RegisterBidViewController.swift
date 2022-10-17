//
//  RegisterBidViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

class RegisterBidViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var radioBid: UIButton!
    @IBOutlet weak var radioTender: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        radioBid.setImage(UIImage(named: "checked radio"), for: .selected)
        radioBid.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioTender.setImage(UIImage(named: "checked radio"), for: .selected)
        radioTender.setImage(UIImage(named: "unchecked radio"), for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func radioButton(_ sender: UIButton) {
        radioBid.isSelected = false
        radioTender.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
