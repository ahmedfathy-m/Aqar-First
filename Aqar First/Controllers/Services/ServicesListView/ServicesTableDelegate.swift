//
//  ServicesTableDelegate.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

extension ServicesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: Service.allCases[indexPath.row].rawValue) else { return }
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
