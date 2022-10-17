//
//  PrioritizedTabBar.swift
//
//  Created by Roman Churkin on 24.12.2019.
//  Copyright © 2019 Redmadrobot. All rights reserved.
//

import UIKit


class PrioritizedTabBar: UITabBar {
    
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let itemWidth: CGFloat = 76
        static let itemHeight: CGFloat = 48
        
        static let indicatorSize: CGFloat = 4
        
        static let indicatorAnimationDuration: TimeInterval = 0.4
        static let indicatorAnimationStartPoint = CGPoint(x: 0.72, y: 0.08)
        static let indicatorAnimationEndPoint =  CGPoint(x: 0.12, y: 0.93)
        
    }
    
    
    // MARK: - Properties
    
    private lazy var indicator: UIView = {
        let circle = CircleView(frame: .zero)
        circle.backgroundColor = tintColor
        addSubview(circle)
        return circle
    }()
    
    private var buttons: [UIControl] {
        return subviews.filter { $0 is UIControl } as! [UIControl]
    }

    override var selectedItem: UITabBarItem? {
        didSet {
            guard let selectedItem = self.selectedItem,
                let index = items?.firstIndex(of: selectedItem) else { return }
            
            if let oldItem = oldValue,
                let oldIndex = items?.firstIndex(of: oldItem),
                index == oldIndex {
                return
            }
            
            animate(index: index)
        }
    }
    
    
    // MARK: - UITabBar
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        indicator.backgroundColor = tintColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let selectedItem = self.selectedItem,
            let index = items?.firstIndex(of: selectedItem) {
            indicator.frame = frame(forIndicatorAt: index)
        }
        
        guard let items = self.items, items.count <= 4 else { return }
        
        guard buttons.count > 0 else { return }
        
        for (index, button) in buttons.enumerated() {
            button.frame = frame(forButtonAt: index)
        }
        
        self.isTranslucent = true
                var tabFrame            = self.frame
                tabFrame.size.height    = 65 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero)
                tabFrame.origin.y       = self.frame.origin.y +   ( self.frame.height - 65 - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero))
                self.layer.cornerRadius = 20
                self.frame            = tabFrame



                self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })

    }
    @IBInspectable var color: UIColor?
       @IBInspectable var radii: CGFloat = 40

       private var shapeLayer: CALayer?
    private func createPath() -> CGPath {
           let path = UIBezierPath(
               roundedRect: bounds,
               byRoundingCorners: [.topLeft, .topRight],
               cornerRadii: CGSize(width: radii, height: 0.0))

           return path.cgPath
       }
    
    override func draw(_ rect: CGRect) {
        addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 0.3
        shapeLayer.shadowColor = UIColor.lightGray.cgColor//UIColor(named: "Color9")!.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0   , height: 0);
        shapeLayer.shadowOpacity = 0.25//0.55
        shapeLayer.shadowRadius = 13.5
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }
    
    // MARK: - Helper
    
    private func frame(forButtonAt buttonIndex: Int) -> CGRect {
        guard let items = self.items else { fatalError() }
        let itemsCount = items.count
        
        guard itemsCount <= 4 else {
            return buttons[buttonIndex].frame
        }
        
        let itemWidth: CGFloat = self.bounds.size.width / CGFloat(itemsCount)  //Constants.itemWidth
        let itemHeight: CGFloat = Constants.itemHeight

    
        let frame: CGRect
        if buttonIndex == 0 {
            frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
        } else {
            frame = CGRect(x: bounds.width - itemWidth * CGFloat(itemsCount - buttonIndex),
                           y: 0,
                           width: itemWidth,
                           height: itemHeight)
        }
        
        return frame
    }
    
    private func frame(forIndicatorAt index: Int) -> CGRect {
        let itemFrame = frame(forButtonAt: index)
        
        return CGRect(x: itemFrame.maxX - itemFrame.width/2 - Constants.indicatorSize/2,
                      y: itemFrame.maxY - Constants.indicatorSize/2,
                      width: Constants.indicatorSize,
                      height: Constants.indicatorSize)
    }
    
    
    // MARK: Animation
    
    private func animate(index: Int) {
        let newIndicatorFrame = frame(forIndicatorAt: index)
        
        let animator =
            UIViewPropertyAnimator(duration: Constants.indicatorAnimationDuration,
                                   controlPoint1: Constants.indicatorAnimationStartPoint,
                                   controlPoint2: Constants.indicatorAnimationEndPoint)
        
        animator.addAnimations {
            self.indicator.frame = newIndicatorFrame
        }
        
        animator.startAnimation()
    }
    
}
