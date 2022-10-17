//
//  AddFloorVC.swift
//  Aqar First
//
//  Created by no one on 12/08/2021.
//

import UIKit

class AddFloorVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var rentalTermStackViewTopCostratintWithFlatView: NSLayoutConstraint!
    @IBOutlet weak var rentalTermStackViewTopCostratintWithShopView: NSLayoutConstraint!
    @IBOutlet weak var addFlatView: UIView!
    @IBOutlet weak var addShopView: UIView!
    @IBOutlet weak var addFlatStackView: UIStackView!
    @IBOutlet weak var addShopStackView: UIStackView!
    @IBOutlet weak var addFlatRadioBtn: Checkbox!
    @IBOutlet weak var addShopRadioBtn: Checkbox!
    @IBOutlet weak var addMorePhotoView: UIView!
    @IBOutlet weak var otherNotesTextView: UITextView!
    @IBOutlet weak var addMainPhotoView: UIView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainPhotoView.roundCorners(.allCorners, radius: 10)
        otherNotesTextView.layer.borderColor = UIColor.lightGray.cgColor
        otherNotesTextView.layer.borderWidth = 0.5
        otherNotesTextView.layer.cornerRadius = 15
        addShopRadioBtn.isChecked = true
        addMorePhotoView.addDashedBorder()
        
        otherNotesTextView.delegate = self
        
        
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)
        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        otherNotesTextView.text = "Other Notes"
        otherNotesTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        if addFlatRadioBtn.isChecked {
            addShopRadioBtn.isChecked = false
            addFlatView.isHidden = false
            addShopView.isHidden = true


        }else{
            addFlatRadioBtn.isChecked = false
            addShopRadioBtn.isChecked = true
            addFlatView.isHidden = true
            addShopView.isHidden = false
            rentalTermStackViewTopCostratintWithShopView.constant = 20


        }
        let addFlatGesture = UITapGestureRecognizer(target: self, action:  #selector(self.addFlatClickAction(sender:)))
        self.addFlatStackView.addGestureRecognizer(addFlatGesture)
        let addShopGesture = UITapGestureRecognizer(target: self, action:  #selector(self.addShopClickAction(sender:)))
        self.addShopStackView.addGestureRecognizer(addShopGesture)
    }
    @objc func addFlatClickAction(sender : UITapGestureRecognizer) {
        // Do what you want
        print("anas")
        addFlatRadioBtn.isChecked = true
        addShopRadioBtn.isChecked = false
        addFlatView.isHidden = false
        addShopView.isHidden = true
        rentalTermStackViewTopCostratintWithShopView.constant = 85

//        rentalTermStackViewTopCostratintWithShopView.isActive = false
    }
    @objc func addShopClickAction(sender : UITapGestureRecognizer) {
        // Do what you want
        print("anas")
        addFlatRadioBtn.isChecked = false
        addShopRadioBtn.isChecked = true
        addFlatView.isHidden = true
//        rentalTermStackViewTopCostratintWithShopView.isActive = true
        rentalTermStackViewTopCostratintWithShopView.constant = 20

        addShopView.isHidden = false
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if otherNotesTextView.textColor == UIColor.lightGray {
            otherNotesTextView.text = nil
            otherNotesTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if otherNotesTextView.text.isEmpty {
            otherNotesTextView.text = "Other Notes"
            otherNotesTextView.textColor = UIColor.lightGray
        }
    }

}
