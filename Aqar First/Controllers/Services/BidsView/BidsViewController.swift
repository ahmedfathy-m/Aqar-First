//
//  BidsViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

class BidsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configureTableView()
    }
    
    // MARK: - TableViewConfiguration
    func configureTableView() {
        tableView.register(BidTenderCell.nib(), forCellReuseIdentifier: BidTenderCell.identifier)
        tableView.dataSource = self
    }
    
    // MARK: - IBActions
    @IBAction func registerBid(_ sender: UIButton) {
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "registerBid") else { return }
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingsModal(_ sender: UIButton) {
        let vc = BottomSheetView()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                return 195
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 28
        }
        self.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
}
