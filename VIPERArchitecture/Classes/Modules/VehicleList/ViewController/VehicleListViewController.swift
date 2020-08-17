//
//  VehicleViewController.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation
import UIKit

class VehicleListViewController: UITableViewController {
    
    var presenter: VehicleListViewToPresenterProtocol?
    var vehicleList = [VehicleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: let tabbar = UITabBarController()
        
        
        navigationItem.title = "Selam"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        
        presenter?.viewDidLoad()
    }
    
}

extension VehicleListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.vehicleList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        if vehicleList[indexPath.row].state == DeviceState.INACTIVE.rawValue {
            cell.configureInactive(deviceInformation: vehicleList[indexPath.row])
        }
        else {
            cell.configureActive(deviceInformation: vehicleList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension VehicleListViewController: VehicleListPresenterToViewProtocol {
    
    func onFetchVehiclesSuccess() {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            guard let vehicleList = self.presenter?.vehicleList else {
                return
            }
            
            self.vehicleList = vehicleList
            
            self.tableView.reloadData()
        }
        //self.refreshControl.endRefreshing()
    }
    
    func onFetchVehiclesFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        //self.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        //HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        //HUD.hide()
    }
    
}
