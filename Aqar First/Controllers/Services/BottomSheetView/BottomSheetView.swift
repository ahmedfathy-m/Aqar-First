//
//  BottomSheetView.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

class BottomSheetView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var radioBid: UIButton!
    @IBOutlet weak var radioTender: UIButton!
    @IBOutlet weak var radioCity: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        radioBid.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioTender.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioCity.setImage(UIImage(named: "unchecked radio"), for: .normal)
        radioBid.setImage(UIImage(named: "checked radio"), for: .selected)
        radioTender.setImage(UIImage(named: "checked radio"), for: .selected)
        radioCity.setImage(UIImage(named: "checked radio"), for: .selected)
    }
    
    // MARK: - IBActions
    
    @IBAction func radioAction(_ sender: UIButton) {
        radioBid.isSelected = false
        radioTender.isSelected = false
        radioCity.isSelected = false
        sender.isSelected = true
    }
    
}
