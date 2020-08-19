//
//  VehicleInteractor.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleListInteractor: VehicleListPresenterToInteractorProtocol {
    
    var presenter: VehicleListInteractorToPresenterProtocol?
    
    func loadVehicles(countryCoordinate: CountryCoordinate) {
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
