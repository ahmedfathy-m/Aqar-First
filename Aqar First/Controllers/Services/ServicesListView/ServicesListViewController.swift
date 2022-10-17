//
//  ServicesListViewController.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class ServicesListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - TableViewConfiguration
    func configureTableView() {
        tableView.contentInset = UIEdgeInsets(top: 36, left: 0, bottom: 0, right: 0)
        tableView.register(ServiceCell.nib(), forCellReuseIdentifier: ServiceCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
