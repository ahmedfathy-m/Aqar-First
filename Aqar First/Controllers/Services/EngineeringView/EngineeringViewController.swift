//
//  EngineeringViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

class EngineeringViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Table View Configuration
    func configureTableView() {
        tableView.register(ServiceProviderCell.nib(), forCellReuseIdentifier: ServiceProviderCell.identifier)
        tableView.dataSource = self
    }
    
    // MARK: - IBActions
    @IBAction func registerAsServiceProvider(_ sender: UIButton) {
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "serviceProvider") else { return }
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
