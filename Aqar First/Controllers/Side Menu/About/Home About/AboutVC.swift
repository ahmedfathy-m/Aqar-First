//
//  AboutVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var tableView:UITableView!

    var items = ["Common questions","Terms and Conditions","Privacy Policy","Who are we"]

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)
        
        self.navigationItem.hidesBackButton = true
        
        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: AboutCell.self)
        tableView.rowHeight = 45

    }

    @IBAction func backTapped(_ sender:Any) {
        popVC(animated: true)
    }
}

extension AboutVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as AboutCell
        cell.itemsLabel.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        
        case 0:
            let vc = CommonQuestionVC()
            navigationController?.pushViewController(vc,animated: true)
            
        case 1:
            let vc = TermsAndConditionsVC()
            navigationController?.pushViewController(vc,animated: true)

        case 2:
            let vc = PrivacyPolicyVC()
            navigationController?.pushViewController(vc,animated: true)

        case 3:
            let vc = WhoAreWeVC()
            navigationController?.pushViewController(vc,animated: true)
        default:
            break
        }
    }
}
