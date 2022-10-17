//
//  CurrentOrdersCell.swift
//  Aqar First
//
//  Created by WesamFayez on 8/11/21.
//

import UIKit

class CurrentOrdersCell: UITableViewCell {

    @IBOutlet weak var headView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headView.addBottomBorder(with: UIColor(hex: "#DBDFE6"), andWidth: 0.01)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
