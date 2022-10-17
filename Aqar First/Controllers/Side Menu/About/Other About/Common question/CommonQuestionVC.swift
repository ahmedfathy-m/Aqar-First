//
//  CommonQuestionVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class CommonQuestionVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)

        self.navigationItem.hidesBackButton = true

        hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: CommenQuestionsCell.self)
        
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 44.0;

    }
    
    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}


extension CommonQuestionVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as CommenQuestionsCell
        return cell
    }
}
