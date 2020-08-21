//
//  VehicleLocationInterface.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit
import MapKit

// MARK: View Input (View -> Presenter) -> Strong Relation
protocol VehicleLocationViewToPresenterProtocol {
    func viewDidLoad(countryCoordinate: CountryCoordinate)
    func getVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: View Output (Presenter -> View) -> Weak Relation
protocol VehicleLocationPresenterToViewProtocol {
    func setupUI()
    func onFetchVehiclesSuccess(vehicles: [VehicleModel])
    func onFetchVehiclesFailure(error: String)
}

// MARK: Interactor Input (Presenter -> Interactor) -> Strong Relation
protocol VehicleLocationPresenterToInteractorProtocol {
    func loadVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: Interactor Output (Interactor -> Presenter) -> Weak Relation
protocol VehicleLocationInteractorToPresenterProtocol: class {
    func fetchVehiclesSuccess(vehicles: [VehicleModel])
    func fetchVehiclesFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router) -> Strong Relation
protocol VehicleLocationPresenterToRouterProtocol {
    
}

protocol VehicleLocationModuleBuilderProtocol {
    func createModule() -> UINavigationController
}
