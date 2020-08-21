//
//  VehicleListModuleBuilder.swift
//  CaseProject
//
//  Created by Arda Onat on 15.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

class VehicleListModuleBuilder: VehicleListModuleBuilderProtocol {
    
    func createModule() -> UINavigationController {
        let viewController = VehicleListViewController()
        let interactor = VehicleListInteractor()
        let router = VehicleListRouter()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = VehicleListPresenter(view: WeakRef(viewController), interactor: interactor, router: router)
        
        interactor.presenter = WeakRef(presenter)
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}

extension WeakRef: VehicleListInteractorToPresenterProtocol where T: VehicleListInteractorToPresenterProtocol {
    
    func fetchVehiclesSuccess(vehicles: [VehicleModel]) {
        object?.fetchVehiclesSuccess(vehicles: vehicles)
    }
    
    func fetchVehiclesFailure(error: Error) {
        object?.fetchVehiclesFailure(error: error)
    }
    
}

extension WeakRef: VehicleListPresenterToViewProtocol where T: VehicleListPresenterToViewProtocol {
    
    func setupUI() {
        object?.setupUI()
    }
    
    func onFetchVehiclesSuccess(vehicles: [VehicleModel]) {
        object?.onFetchVehiclesSuccess(vehicles: vehicles)
    }
    
    func onFetchVehiclesFailure(error: String) {
        object?.onFetchVehiclesFailure(error: error)
    }
}
