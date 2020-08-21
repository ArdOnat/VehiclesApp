//
//  VehicleLocationPresenter.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

class VehicleLocationPresenter {

    var view: VehicleLocationPresenterToViewProtocol?
    var interactor: VehicleLocationPresenterToInteractorProtocol?
    var router: VehicleLocationPresenterToRouterProtocol?
    
    init( view: VehicleLocationPresenterToViewProtocol, interactor: VehicleLocationPresenterToInteractorProtocol, router: VehicleLocationPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
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
        view?.onFetchVehiclesSuccess(vehicles: vehicles)
    }
    
    func fetchVehiclesFailure(error: Error) {
        view?.onFetchVehiclesFailure(error: error.localizedDescription)
    }
    
}
