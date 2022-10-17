//
//  ServiceProviderCell.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 17/10/2022.
//

import UIKit

class ServiceProviderCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var sbLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Nib
    static let identifier = "ServiceProviderCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ServiceProviderCell", bundle: .main)
    }
    
}
