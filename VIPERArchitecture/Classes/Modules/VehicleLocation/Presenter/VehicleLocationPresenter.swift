//
//  VehicleLocationPresenter.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleLocationPresenter {

    var view: VehicleLocationPresenterToViewProtocol?
    var interactor: VehicleLocationPresenterToInteractorProtocol?
    var router: VehicleLocationPresenterToRouterProtocol?
    var vehicleList: [VehicleModel]?
    
    func viewDidLoad(countryCoordinate: CountryCoordinate) {
        getVehicles(countryCoordinate: countryCoordinate)
    }
    
}

extension VehicleLocationPresenter: VehicleLocationViewToPresenterProtocol {

    func getVehicles(countryCoordinate: CountryCoordinate) {
        interactor?.loadVehicles(countryCoordinate: countryCoordinate)
    }
    
}

extension VehicleLocationPresenter: VehicleLocationInteractorToPresenterProtocol {
    
    func fetchVehiclesSuccess(vehicles: [VehicleModel]) {
        self.vehicleList = vehicles
        view?.onFetchVehiclesSuccess()
    }
    
    func fetchVehiclesFailure(error: Error) {
        view?.onFetchVehiclesFailure(error: error.localizedDescription)
    }
    
}
