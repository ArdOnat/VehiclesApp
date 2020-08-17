//
//  VehiclePresenter.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleListPresenter {
    
    // MARK: Properties
    var view: VehicleListPresenterToViewProtocol?
    var interactor: VehicleListPresenterToInteractorProtocol?
    var router: VehicleListPresenterToRouterProtocol?
    
    var vehicleList: [VehicleModel]?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        //view?.showHUD()
        let countryCoordinate = CountryCoordinate(p2Lat: 53.694865, p1Lon:9.757589, p1Lat: 53.394655, p2Lon: 10.099891) // Hamburg
        interactor?.loadVehicles(countryCoordinate: countryCoordinate)
    }
}


extension VehicleListPresenter: VehicleListViewToPresenterProtocol {
    
    func refresh() {
        
    }
    
    func numberOfRowsInSection() -> Int {
        if let vehicleList = vehicleList {
            return vehicleList.count
        }
        else {
            return 0
        }
    }
    
}

extension VehicleListPresenter: VehicleListInteractorToPresenterProtocol {
    
    func fetchVehiclesSuccess(vehicles: [VehicleModel]) {
        self.vehicleList = vehicles
        self.view?.onFetchVehiclesSuccess()
    }
    
    func fetchVehiclesFailure(error: Error) {
    
    }
}
