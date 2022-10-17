//
//  AqarListVC.swift
//  Aqar First
//
//  Created by no one on 13/08/2021.
//

import UIKit

class AqarListVC: BaseWireframe<AqarListViewModel> {

    @IBOutlet weak var tableView:UITableView!
    
    override func bind(with viewModel: AqarListViewModel) {
        super.bind(with: viewModel)
        viewModel.loadData()
        
        viewModel.item.subscribe ( onNext:{ [weak self]  (items) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: self.disposeBag)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bind(with: viewModel)
        //hideNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: AqarListTableViewCell.self)
        tableView.rowHeight = 96
        tableView.separatorColor = UIColor(hex: "#E6E6E6")
        tableView.tableFooterView = UIView()
        
        
    }
}

extension AqarListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.item.value?.data.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as AqarListTableViewCell
        let item = viewModel.item.value?.data[indexPath.row]
        cell.aqarTitileLabel.text = item?.name
        return cell
    }
}
