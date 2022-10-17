//
//  AqarLocationVCViewController.swift
//  Aqar First
//
//  Created by no one on 14/08/2021.
//

import UIKit

class AqarLocationVC: UIViewController ,UITextViewDelegate{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var locationTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextView.layer.cornerRadius = 10
        locationTextView.delegate = self
        locationTextView.text = "Enter the full Locationn"
        locationTextView.textColor = UIColor.lightGray
        
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)
        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if locationTextView.textColor == UIColor.lightGray {
            locationTextView.text = nil
            locationTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if locationTextView.text.isEmpty {
            locationTextView.text = "Enter the full Locationn"
            locationTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }

}
