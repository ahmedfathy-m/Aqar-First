//
//  AqarStatusVCViewController.swift
//  Aqar First
//
//  Created by no one on 11/08/2021.
//

import UIKit

class AqarStatusVC: UIViewController {

    @IBOutlet weak var availablePropertyBtn: UIButton!
    @IBOutlet weak var rentedPropertyBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var avallablePropertyView: UIView!
    @IBOutlet weak var rentedPropertyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)
        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func availablePropertyBtnDidPressed(_ sender: Any) {
        availablePropertyBtn.backgroundColor = UIColor(hex: "#4D959B")
        availablePropertyBtn.setTitleColor(.white, for: .normal)
        rentedPropertyBtn.backgroundColor = .white
        rentedPropertyBtn.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        avallablePropertyView.isHidden = false
        rentedPropertyView.isHidden = true
    }
    
    
    @IBAction func rentedPropertyBtnDidPressed(_ sender: Any) {
        rentedPropertyBtn.backgroundColor = UIColor(hex: "#4D959B")
        rentedPropertyBtn.setTitleColor(.white, for: .normal)
        availablePropertyBtn.backgroundColor = .white
        availablePropertyBtn.setTitleColor(UIColor(hex: "#4D959B"), for: .normal)
        avallablePropertyView.isHidden = true
        rentedPropertyView.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
