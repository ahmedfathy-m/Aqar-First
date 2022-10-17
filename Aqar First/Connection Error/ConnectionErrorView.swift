//
//  MyTripsEmptyView.swift
//  customer
//
//

import UIKit

class ConnectionErrorView: UIViewController {
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    var tryAction:(()->Void)?
    var type:EmptyViewType = .internetConnection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .serverError:
            self.firstLabel.text = "Server Problem".localized
            self.secondLabel.text = "Seems server is down please check your connection and try again".localized
            break
        case .internetConnection:
            self.firstLabel.text = "Oops, looks you are not connected".localized
            self.secondLabel.text = "please check your internet connection and try again".localized
            break
        default:
            break
        }
    }
    
    @IBAction func tryDidPressed(_ sender: Any) {
        
        self.tryAction?()
    }
    
}
