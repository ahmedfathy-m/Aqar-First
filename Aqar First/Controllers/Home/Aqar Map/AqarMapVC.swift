//
//  AqarMapVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class AqarMapVC: BaseWireframe<AqarListViewModel> , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?



    override func bind(with viewModel: AqarListViewModel) {
        super.bind(with: viewModel)
        
        viewModel.loadData()
                
        viewModel.item.subscribe ( onNext:{ [weak self]  (items) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }).disposed(by: self.disposeBag)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bind(with: viewModel)
        //hideNavigationBar()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellNib(cellClass: HomeItemCollectionViewCell.self)
        
        initializeTheLocationManager()
        self.mapView.delegate = self


    }
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Set up CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locationManager.location?.coordinate
        

        cameraMoveToLocation(toLocation: location)
        let position = CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)

        let marker = GMSMarker(position: position)
        marker.icon = UIImage(named: "currLocation")
        marker.map = mapView
        
        locationManager.stopUpdatingLocation()

    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if currentLocation == nil {
            self.currentLocation = toLocation
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }
}

extension AqarMapVC : GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
      
    }
}

extension AqarMapVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.item.value?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(for: indexPath) as HomeItemCollectionViewCell
        let item = viewModel.item.value?.data[indexPath.row]
        cell.aqarTitile.text = item?.name

        if  item?.datumDescription == nil  {
            cell.aqarDescriptionLabel.text = "There is No Description Available Now.".localized
        }else {
            cell.aqarDescriptionLabel.text = item?.datumDescription
            cell.aqarDescriptionLabel.layoutIfNeeded()

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat = UIScreen.main.bounds.size.width / 1.4
        
        return CGSize(width:cellWidth, height: 140)
    }

    
}
//
////MARK: - UICollectionViewDelegateFlowLayout
//extension AqarMapVC: UICollectionViewDelegateFlowLayout {
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//   let width:CGFloat = UIScreen.main.bounds.width //- 50
//   let height:CGFloat = 140
//   return CGSize(width: width/2, height: height)
//  }
//}
