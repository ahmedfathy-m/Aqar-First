//
//  DetailsOrderVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class DetailsOrderVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: DetailsOrderCell.self)
        tableView.rowHeight = 310
        tableView.separatorColor = UIColor(hex: "#E6E6E6")
        
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true

    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}


extension DetailsOrderVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as DetailsOrderCell
        return cell
    }
}
