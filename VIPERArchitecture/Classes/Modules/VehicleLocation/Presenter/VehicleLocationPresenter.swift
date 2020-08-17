//
//  VehicleLocationPresenter.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleLocationPresenter {

    // MARK: Properties
    var view: VehicleLocationPresenterToViewProtocol?
    var interactor: VehicleLocationPresenterToInteractorProtocol?
    var router: VehicleLocationPresenterToRouterProtocol?
    
    var vehicleList: [VehicleModel]?
    
    // MARK: Inputs from view
    
    func viewDidLoad(countryCoordinate: CountryCoordinate) {
        print("Presenter is being notified that the View was loaded.")
        //view?.showHUD()
        
        interactor?.loadVehicles(countryCoordinate: countryCoordinate)
    }
    
}

extension VehicleLocationPresenter: VehicleLocationViewToPresenterProtocol {

    func onMapDragged(countryCoordinate: CountryCoordinate) {
        interactor?.loadVehicles(countryCoordinate: countryCoordinate)
    }
    
    func refresh() {
        
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
