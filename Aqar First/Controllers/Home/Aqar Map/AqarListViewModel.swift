//
//  AqarListViewModel.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import Foundation
import RxCocoa
import RxSwift

class AqarListViewModel : BaseViewModel {
    
    var item:BehaviorRelay = BehaviorRelay<Aqar?>(value:nil )
    
    
    func loadData(refersh:Bool = false) {

        
        self.isLoaderHidden.onNext(.show)

        let endPoint = APIEndpoints.getArarBuildings()
        self.apiManager.request(with: endPoint) {[weak self] result in
            self?.isLoaderHidden.onNext(.hide)

            switch result {
            case .success(let value):
//                self?.item = value
                self?.item.accept(value)
                print("hhhhhh")
                print(self?.item.value?.data.first?.name)
                print(self?.item.value?.data.first?.datumDescription)
                print("mmmmmm")
            case .failure(let error):
                self?.handelError(error: error)

                break
            }
        }
    }

}
