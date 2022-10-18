//
//  EngineeringServicesDatasource.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

extension EngineeringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceProviderCell.identifier, for: indexPath)
        return cell
    }
    
    
}
