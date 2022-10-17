//
//  ServiceCell.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class ServiceCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var serviceLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Nib
    static let identifier = "ServiceCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ServiceCell", bundle: .main)
    }
    
}
