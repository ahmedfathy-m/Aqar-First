//
//  FinancingViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class FinancingViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var swapView: UIView!
    @IBOutlet weak var pageSwitcher: UISegmentedControl!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        pageChange(pageSwitcher)
    }
    
    // MARK: - IBActions
    @IBAction func pageChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1: addSahlView()
        case 0: addBiladView()
        default: swapView.removeSubviews()
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    fileprivate func addBiladView() {
        swapView.removeSubviews()
        let vc = BiladViewController()
        addChild(vc)
        swapView.addSubview(vc.view)
        vc.view.frame = swapView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate func addSahlView() {
        swapView.removeSubviews()
        let vc = SahlViewController()
        addChild(vc)
        swapView.addSubview(vc.view)
        vc.view.frame = swapView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
