//
//  PendingOrdersVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class PendingOrdersVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: PendingOrdersCell.self)
        tableView.rowHeight = 177
        tableView.separatorColor = UIColor(hex: "#E6E6E6")
    }

}


extension PendingOrdersVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as PendingOrdersCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsOrderVC()
        navigationController?.pushViewController(vc,animated: true)
    }
}

