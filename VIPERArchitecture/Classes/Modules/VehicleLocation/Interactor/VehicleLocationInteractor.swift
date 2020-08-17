//
//  VehicleLocationInteractor.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleLocationInteractor: VehicleLocationPresenterToInteractorProtocol {
    
    // MARK: Properties
    var presenter: VehicleLocationInteractorToPresenterProtocol?
    
    func loadVehicles(countryCoordinate: CountryCoordinate) {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        VehicleService.getVehicleList(coordinate: countryCoordinate) { result in
            switch result {
            case .success(let response):
                let vehicleList = response.poiList.map { VehicleModel(fromVehicleInformation: $0)}
                self.presenter?.fetchVehiclesSuccess(vehicles: vehicleList)
            case .failure(let error):
                self.presenter?.fetchVehiclesFailure(error: error)
            }
        }
    }
    
}
