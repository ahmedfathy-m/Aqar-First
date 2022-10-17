//
//  RightSideMenuVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class RightSideMenuVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    let items = ["my Estate", "Services","Orders","Contract Documentation","Mortgage","Settings","Profile","Contact us","About","Rate App","Log out"]
    
    let icons = ["building","maintenance","orders","contract","contract (1)","Setting","profile","Calling","about","rate","Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: RightSideCell.self)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }
}



extension RightSideMenuVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RightSideCell
        cell.sideItemLabel.text = items[indexPath.row]
        cell.sideIcon.image = UIImage(named: icons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = MyAqarVC()
            navigationController?.pushViewController(vc, animated: true)

        break
        case 2:
            let vc = OrdersVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = ContractDocumentationVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = MortgageVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            let vc = ProfileVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = ContactUsVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 8:
            let vc = AboutVC()
            navigationController?.pushViewController(vc, animated: true)

            
        default:
            break
        }
    }

}
