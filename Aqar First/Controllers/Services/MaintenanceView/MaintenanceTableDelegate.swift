//
//  MaintenanceTableDelegate.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

extension MaintenanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
