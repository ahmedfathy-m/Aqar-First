//
//  MortgageVC.swift
//  Aqar First
//
//

import UIKit

class MortgageVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var tableView:UITableView!


    let imagArr = ["bank-center","bank=ahli"]
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true
        
        hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: MortgageCell.self)
        tableView.rowHeight = 142
//        tableView.tableFooterView = UIView()

    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}


extension MortgageVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as MortgageCell
        cell.imageMortage.image = UIImage(named: imagArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsMortgageVC()
        navigationController?.pushViewController(vc,animated: true)
    }
}
