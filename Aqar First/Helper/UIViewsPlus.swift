//
//  UIViewsPlus.swift
//  Aqar First
//
//  Created by Mina Mohareb on 23/09/2022.
//

import UIKit


extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

public extension UIView {
    func fillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = superview.translatesAutoresizingMaskIntoConstraints
        if translatesAutoresizingMaskIntoConstraints {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            frame = superview.bounds
        } else {
            
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }

}


extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
    
    
       func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        
    }
    func shadowDecorateView() {
        let radius: CGFloat = 6
        layer.cornerRadius = radius
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 4, height: 4.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.4
        layer.borderWidth = 0.1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
        
//        layer.cornerRadius = 5.0
//        layer.borderColor  =  UIColor.clear.cgColor
//        layer.borderWidth = 0.1
//        layer.borderColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowColor =  UIColor.lightGray.cgColor
//        layer.shadowRadius = 12.0
//        layer.shadowOffset = CGSize(width:3, height: 3)
//        layer.masksToBounds = true

    }
    
    func setNoShadow() {
        let radius: CGFloat = 0
        layer.cornerRadius = radius
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.borderWidth = 0

        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    //MARK: - Add Border to View
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}

extension UIView {
    func setBorder() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "3C89F6").cgColor
        
    }
    func setNoBorder() {
        layer.borderWidth = 0

    }
}


extension UIView {
    func lock() {
      if let _ = viewWithTag(10) {
        //View is already locked
      }
      else {
        let lockView = UIView(frame: bounds)
        lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        lockView.tag = 10
        lockView.alpha = 0.0
        let activity = UIActivityIndicatorView(style: .white)
        activity.hidesWhenStopped = true
        activity.center = lockView.center
        lockView.addSubview(activity)
        activity.startAnimating()
        addSubview(lockView)
        
        UIView.animate(withDuration: 0.2, animations: {
          lockView.alpha = 1.0
        })
      }
    }
    
    func unlock() {
      if let lockView = viewWithTag(10) {
        UIView.animate(withDuration: 0.2, animations: {
          lockView.alpha = 0.0
        }, completion: { finished in
          lockView.removeFromSuperview()
        })
      }
    }
}


extension UIView {
    func roundCornersTR(with CACornerMask: CACornerMask, radius: CGFloat) {
              self.layer.cornerRadius = radius
              self.layer.maskedCorners = [CACornerMask]
        }
}
