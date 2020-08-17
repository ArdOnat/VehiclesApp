//
//  VehicleLocationInterface.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

// MARK: View Input (View -> Presenter)
protocol VehicleLocationViewToPresenterProtocol {
var view: VehicleLocationPresenterToViewProtocol? { get set }
var interactor: VehicleLocationPresenterToInteractorProtocol? { get set }
var router: VehicleLocationPresenterToRouterProtocol? { get set }
var vehicleList: [VehicleModel]? { get set }
func viewDidLoad(countryCoordinate: CountryCoordinate)
func getVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: View Output (Presenter -> View)
protocol VehicleLocationPresenterToViewProtocol {
func setupUI()
func onFetchVehiclesSuccess()
func onFetchVehiclesFailure(error: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol VehicleLocationPresenterToInteractorProtocol {
var presenter: VehicleLocationInteractorToPresenterProtocol? { get set }
func loadVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol VehicleLocationInteractorToPresenterProtocol {
func fetchVehiclesSuccess(vehicles: [VehicleModel])
func fetchVehiclesFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol VehicleLocationPresenterToRouterProtocol {
    
}
