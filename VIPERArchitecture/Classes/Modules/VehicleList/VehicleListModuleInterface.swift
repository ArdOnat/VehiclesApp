//
//  VehicleListModuleInterface.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

// MARK: View Input (View -> Presenter)
protocol VehicleListViewToPresenterProtocol {
var view: VehicleListPresenterToViewProtocol? { get set }
var interactor: VehicleListPresenterToInteractorProtocol? { get set }
var router: VehicleListPresenterToRouterProtocol? { get set }
var vehicleList: [VehicleModel]? { get set }
func viewDidLoad()
func getVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: View Output (Presenter -> View)
protocol VehicleListPresenterToViewProtocol {
var vehicleList: [VehicleModel] { get set }
func setupUI()
func onFetchVehiclesSuccess()
func onFetchVehiclesFailure(error: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol VehicleListPresenterToInteractorProtocol {
var presenter: VehicleListInteractorToPresenterProtocol? { get set }
func loadVehicles(countryCoordinate: CountryCoordinate)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol VehicleListInteractorToPresenterProtocol {
func fetchVehiclesSuccess(vehicles: [VehicleModel])
func fetchVehiclesFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol VehicleListPresenterToRouterProtocol {
    
}
