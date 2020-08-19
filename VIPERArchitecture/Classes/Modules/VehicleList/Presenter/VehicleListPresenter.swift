//
//  VehiclePresenter.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

class VehicleListPresenter {
    
    var view: VehicleListPresenterToViewProtocol?
    var interactor: VehicleListPresenterToInteractorProtocol?
    var router: VehicleListPresenterToRouterProtocol?
    var vehicleList: [VehicleModel]?
    
    func viewDidLoad() {
        let countryCoordinate = ConstantCoordinates.Hamburg
        getVehicles(countryCoordinate: countryCoordinate)
    }
    
}

extension VehicleListPresenter: VehicleListViewToPresenterProtocol {
    
    func getVehicles(countryCoordinate: CountryCoordinate) {
        interactor?.loadVehicles(countryCoordinate: countryCoordinate)
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
