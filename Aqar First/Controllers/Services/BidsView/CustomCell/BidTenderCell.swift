//
//  BidTenderCell.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import UIKit

class BidTenderCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var typeLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Nib
    static let identifier = "BidTenderCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BidTenderCell", bundle: .main)
    }
    
}
