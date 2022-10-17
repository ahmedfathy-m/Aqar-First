//
//  TermsAndConditionsVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)

        self.navigationItem.hidesBackButton = true

        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: TermsAndConditionsCell.self)
        tableView.tableFooterView = UIView()

    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}


extension TermsAndConditionsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as TermsAndConditionsCell
        return cell
    }
}
