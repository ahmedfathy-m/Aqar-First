//
//  FavoriteVC.swift
//  Aqar First
//
//  Created by Mina Mohareb on 23/09/2022.
//

import UIKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellNib(cellClass: FavoriteCell.self)
        
        headerView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 20)
        headerView.roundCornersTR(with: [.layerMinXMaxYCorner], radius: 20)

        headerView.roundCornersTR(with: [.layerMaxXMaxYCorner], radius: 20)

    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FavoriteVC: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0//3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(for: indexPath) as FavoriteCell
        return  cell
        
    }
  
}


//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteVC: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   let width:CGFloat = UIScreen.main.bounds.width - 90
   let height:CGFloat = 156
   return CGSize(width: width/2, height: height)
}
}

