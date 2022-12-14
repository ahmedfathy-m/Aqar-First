//
//  UICollectionViewPlus.swift
//  Aqar First
//
//  Created by Mina Mohareb on 23/09/2022.
//

import UIKit

extension UICollectionView{
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
           self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
       }
       
       
       func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell{
           let identifier = String(describing: Cell.self)
           
           guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
               fatalError("Error in cell")
           }
           
           return cell
       }
}
