//
//  FurnitureServiceViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class FurnitureServiceViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - TableViewConfiguration
    func configureTableView() {
        tableView.register(ServiceProviderCell.nib(), forCellReuseIdentifier: ServiceProviderCell.identifier)
        tableView.dataSource = self
    }
    
    // MARK: - IBActions
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
