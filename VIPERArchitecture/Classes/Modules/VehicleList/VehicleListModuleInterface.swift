//
//  VehicleListModuleInterface.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

// MARK: View Input (View -> Presenter) -> Strong Relation
protocol VehicleListViewToPresenterProtocol {
    func viewDidLoad()
    func getVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: View Output (Presenter -> View) -> Weak Relation
protocol VehicleListPresenterToViewProtocol {
    func setupUI()
    func onFetchVehiclesSuccess(vehicles: [VehicleModel])
    func onFetchVehiclesFailure(error: String)
}

// MARK: Interactor Input (Presenter -> Interactor) -> Strong Relation
protocol VehicleListPresenterToInteractorProtocol {
    func loadVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: Interactor Output (Interactor -> Presenter) -> Weak Relation
protocol VehicleListInteractorToPresenterProtocol: class {
    func fetchVehiclesSuccess(vehicles: [VehicleModel])
    func fetchVehiclesFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router) -> Strong Relation
protocol VehicleListPresenterToRouterProtocol {
    
}

protocol VehicleListModuleBuilderProtocol {
    func createModule() -> UINavigationController
}
